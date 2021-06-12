import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Text(
              "The WORLD will END in ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: (25),
                // fontWeight: FontWeight.bold,
              ),
            ),
            TweenAnimationBuilder(
              tween: Tween(begin: 60.0, end: 0),
              duration: Duration(seconds: 120),
              builder: (context, value, child) => Text(
                "00:${value}",
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
              onEnd: () {},
            ),
            SizedBox(height: 90),
            Center(
              child: RotationTransition(
                child: Image.asset('assets/real.png'),
                alignment: Alignment.center,
                turns: _animationController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
