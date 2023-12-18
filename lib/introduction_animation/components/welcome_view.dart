import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  final AnimationController animationController;
  const WelcomeView({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _secondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.8,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final _welcomeFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _welcomeImageAnimation =
        Tween<Offset>(begin: const Offset(4, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                SlideTransition(
                  position: _welcomeImageAnimation,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 350, maxHeight: 350),
                    child: Image.asset(
                      'assets/introduction_animation/shivv.jpeg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SlideTransition(
                  position: _welcomeFirstHalfAnimation,
                  child: const Text(
                    "रामेश्वरम",
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 64, right: 64, top: 16, bottom: 16),
                  child: Text(
                    "हिन्दुओं के चार धामों में से एक है। इसके अलावा यहां स्थापित शिवलिंग बारह द्वादश ज्योतिर्लिंगों में से एक माना जाता है",
                    textAlign: TextAlign.center,
                  ),
                ),
                // Padding(
                //   padding:
                //   EdgeInsets.only(left: 40, right: 40,),
                //   child: TextFormField(
                //     style: TextStyle(color: Color(0xFF17262A)),
                //     obscureText: false,
                //     decoration: const InputDecoration(
                //         border: InputBorder.none,
                //         errorStyle: TextStyle(color: Colors.red),
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Color(0xFF17262A)),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Color(0xFF17262A)),
                //         ),
                //         fillColor: Colors.transparent,
                //         filled: true,
                //         hintText: 'Phone Number',
                //         labelText: 'Phone Number',
                //         labelStyle: TextStyle(color: Color(0xFF17262A)),
                //         hintStyle: TextStyle(color: Color(0xFF17262A))),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
