import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramkripa/model/home_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:video_player/video_player.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(
          Icons.ac_unit,
          color: Colors.white,
        ),
        title: const Text(
          'राम कृपा',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffff9933),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          Icons.home_max_outlined,
          color: Colors.blueAccent,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          Icons.home,
          Icons.access_time,
          Icons.holiday_village,
          Icons.account_tree_rounded
        ],
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchMargin: 8,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        backgroundColor: const Color(0xffff9933),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          // Your existing code for fetching and displaying data
          StreamBuilder<List<HomeItemData>>(
            stream: getHomeItemStreamFromFirestore(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show a loading indicator while data is being fetched
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<HomeItemData> users = snapshot.data ?? [];
                return PageView.builder(
                  itemCount: users.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return SinglePage(item: users[index]);
                  },
                );
              }
            },
          ),
          // Add more pages as needed
        ],
      ),
    );
  }
}
class SinglePage extends StatelessWidget {
  const SinglePage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final HomeItemData item;

  @override
  Widget build(BuildContext context) {
    final VideoPlayerController _videoPlayerController =
    VideoPlayerController.network(item.image);
    final ChewieController _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
      autoPlay: true,
      looping: true,
      placeholder: Center(
        child: CircularProgressIndicator(),
      ),
    );

    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.blueAccent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 500, // Adjust the height as needed
                            child: Chewie(controller: _chewieController),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 20,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                item.name ?? "Unknown",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          Text(
                            item.des ?? "",
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                            style: TextStyle(color: Colors.black),
                          ),
                          Flexible(flex: 1, child: Buttons()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class Buttons extends StatelessWidget {
  const Buttons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.heart_broken_outlined,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.message_outlined,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.share,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

Stream<List<HomeItemData>> getHomeItemStreamFromFirestore() {
  return FirebaseFirestore.instance.collection('homevideo').snapshots().map(
        (querySnapshot) {
      List<HomeItemData> itemmenu = [];
      try {
        for (var doc in querySnapshot.docs) {
          var gg = doc.data() as Map;
          itemmenu.add(HomeItemData(
            name: gg['name'],
            des: gg['des'],
            image: gg['image'],
            docid: doc.id,
          ));
        }
      } catch (e) {
        print(e.toString());
        throw Exception(e.toString());
      }
      return itemmenu;
    },
  );
}
