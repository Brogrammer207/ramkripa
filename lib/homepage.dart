import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
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
  bool fullscreen = false;

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
        icons: const [
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
          StreamBuilder<List<HomeItemData>>(
            stream: getHomeItemStreamFromFirestore(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // Show a loading indicator while data is being fetched
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

class SinglePage extends StatefulWidget {
  SinglePage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final HomeItemData item;

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  bool fullscreen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 465, // Adjust the height as needed
                            child: Padding(
                              padding: fullscreen
                                  ? EdgeInsets.zero
                                  : const EdgeInsets.only(top: 32.0),
                              child: YoYoPlayer(
                                aspectRatio: 16 / 9,
                                url:
                                    // 'https://dsqqu7oxq6o1v.cloudfront.net/preview-9650dW8x3YLoZ8.webm',
                                    // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                                    "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
                                //"https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8",
                                allowCacheFile: true,
                                onCacheFileCompleted: (files) {
                                  print(
                                      'Cached file length ::: ${files?.length}');

                                  if (files != null && files.isNotEmpty) {
                                    for (var file in files) {
                                      print('File path ::: ${file.path}');
                                    }
                                  }
                                },
                                onCacheFileFailed: (error) {
                                  print('Cache file error ::: $error');
                                },
                                videoStyle: const VideoStyle(
                                  fullscreenIcon: Icon(
                                    Icons.fullscreen,
                                    color: Colors.black,
                                  ),
                                  qualityStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                  forwardAndBackwardBtSize: 30.0,
                                  forwardIcon: Icon(
                                    Icons.skip_next_outlined,
                                    color: Colors.black,
                                  ),
                                  backwardIcon: Icon(
                                    Icons.skip_next_outlined,
                                    color: Colors.black,
                                  ),
                                  playButtonIconSize: 40.0,
                                  playIcon: Icon(
                                    Icons.play_circle,
                                    size: 40.0,
                                    color: Colors.black,
                                  ),
                                  pauseIcon: Icon(
                                    Icons.remove_circle_outline_outlined,
                                    size: 40.0,
                                    color: Colors.black,
                                  ),
                                  videoQualityPadding: EdgeInsets.all(5.0),
                                  showLiveDirectButton: true,
                                  enableSystemOrientationsOverride: false,
                                ),
                                videoLoadingStyle: const VideoLoadingStyle(
                                  loading: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/images/progress.gif'),
                                          fit: BoxFit.fitHeight,
                                          height: 50,
                                        ),
                                        SizedBox(height: 16.0),
                                        Text("Loading video..."),
                                      ],
                                    ),
                                  ),
                                ),
                                videoPlayerOptions: VideoPlayerOptions(
                                    allowBackgroundPlayback: true),
                                autoPlayVideoAfterInit: false,
                                onFullScreen: (value) {
                                  setState(() {
                                    if (fullscreen != value) {
                                      fullscreen = value;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.item.name ?? "Unknown",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.item.date ?? "Unknown",
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    const Text.rich(
                                      TextSpan(
                                        children: [
                                          WidgetSpan(
                                              child: Icon(
                                            Icons.message,
                                            size: 15,
                                          )),
                                          TextSpan(text: 'Comment'),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        'assets/introduction_animation/hand.png',
                                        height: 23,
                                        width: 23,
                                      )),
                                  const Text(
                                    '23',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        'assets/images/flowers.png',
                                        height: 23,
                                        width: 23,
                                      )),
                                  const Text(
                                    '23',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        'assets/images/bell.png',
                                        height: 23,
                                        width: 23,
                                      )),
                                  const Text(
                                    '23',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        'assets/images/diya.png',
                                        height: 23,
                                        width: 23,
                                      )),
                                  const Text(
                                    '23',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                              // IconButton(
                              //   onPressed: () {},
                              //     icon: Image.asset('assets/images/ladu.png',height: 23,width: 23,)
                              //
                              // ),
                              // const Padding(
                              //   padding: EdgeInsets.only(top: 15,bottom: 15),
                              //   child: VerticalDivider(
                              //     color: Colors.grey,
                              //     thickness: 1,
                              //   ),
                              // ),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () async {

                                      },
                                      icon: Image.asset(
                                        'assets/images/share.gif',
                                        height: 50,
                                        width: 50,
                                      )),
                                  const Text(
                                    'Share',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ],
                          )
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
            date: gg['date'],
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
