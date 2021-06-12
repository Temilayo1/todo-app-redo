import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
    required TextStyle style,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 80,
        ),
        Text(
          "NOTED",
          style: TextStyle(
            fontSize: (30),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Spacer(
          flex: 1,
        ),
        Image.asset(
          image,
          height: size.height / 7,
          width: (double.infinity),
        ),
        Text(text,
            style: TextStyle(
              color: Colors.white,
              fontSize: (15),
            ),
            textAlign: TextAlign.center),
      ],
    );
  }
}
