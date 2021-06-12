import 'dart:async';

import 'package:fam_church/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// class Contants {
//    Constants._();
//   static const double padding = 20;
//   static const double avatarRadius = 20;
// }

class LogOut extends StatefulWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  bool darkTheme = false;
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(left: 20, top: 20 + 20, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: darkTheme ? Colors.red : Color(0xff121421),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Logging Out",
                style: TextStyle(
                  color: darkTheme ? Colors.black : Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "please wait...",
                style: TextStyle(
                  fontSize: 14,
                  color: darkTheme ? Colors.black : Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 42,
              ),
              SpinKitPouringHourglass(color: Colors.white)
              // LinearProgressIndicator(
              //   backgroundColor: Colors.grey,
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              // )
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(45)),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/1.jpg'),
                // child: Text("LA"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
