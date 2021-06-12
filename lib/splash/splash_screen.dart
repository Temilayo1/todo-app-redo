import 'package:flutter/material.dart';

import 'components/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    //   SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff202124),
      body: Body(),
    );
  }
}
