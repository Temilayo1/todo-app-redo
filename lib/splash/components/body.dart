import 'dart:async';

import 'package:fam_church/sign-in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'splash_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignIn(),
        ),
      ),
    );
  }
  //   @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

  Duration kAnimationDuration = const Duration(milliseconds: 200);
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Discover new local products and earn \npoints for shopping",
      "image": "assets/1.jpg",
    },
    {
      "text": "Use our safe and easy payment  \nplatform with no worries",
      "image": "assets/1.jpg",
    },
    {
      "image": "assets/1.jpg",
      "text": "Find favorites items and get delivery \nat your door-step",
    },
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  //key: null,
                  image: 'assets/splash.jpeg',
                  text: 'your one way',
                  style: TextStyle(
                    fontSize: (30),
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: (50)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    SpinKitFoldingCube(
                      color: Colors.red,
                    ),
                    Spacer(flex: 5),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ),
                        );
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            "CONTINUE",
                            style: TextStyle(
                              letterSpacing: 5,
                              fontSize: (22),
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        width: double.infinity,
                        height: size.height / 17,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.redAccent),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      // duration: kAnimationDuration,
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
