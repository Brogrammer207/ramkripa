import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<IconData> iconList = [
    Icons.home,
    Icons.access_time,
    Icons.holiday_village,
    Icons.account_tree_rounded
  ];
  final controller = PageController();


  // default index of the tabs
  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.ac_unit,color: Colors.white,),
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
          onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        // navigation bar
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchMargin: 8,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        backgroundColor: const Color(0xffff9933),
      ),
      body: PageView(
        controller: controller,
        scrollDirection: Axis.vertical,
        padEnds: false,
        children: [
          SinglePage(
            widget: Image.asset('assets/images/inviteImage.png'),
          ),
          SinglePage(
            widget: Image.asset('assets/images/inviteImage.png'),

          ),
          SinglePage(
            widget: Image.asset('assets/images/inviteImage.png'),

          ),
          SinglePage(
              widget: Image.asset('assets/images/inviteImage.png'),
    ),

          SinglePage(
            widget: Image.asset('name'),

          ),
        ],
      )
    );
  }
}
class SinglePage extends StatelessWidget {
  const SinglePage({
    Key? key,
    required this.widget
  }) : super(key: key);
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
                        Image.asset("assets/images/inviteImage.png"),
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 20,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Name of user",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          "This is the very long description of the videos which has many lines This is the very long description of the videos which has many lines This is the very long description of the videos which has many lines This is the very long description of the videos which has many lines",
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 2,
                          style: TextStyle(color: Colors.black),
                        ),
                        Flexible(flex: 1, child: Buttons())

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ]);
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
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.message_outlined,
              color: Colors.black,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            )),
      ],
    );
  }
}