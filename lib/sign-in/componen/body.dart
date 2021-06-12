import 'dart:ui';

import 'package:fam_church/sign-in/componen/signInForm.dart';
import 'package:flutter/material.dart';

//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../../home.dart';

class Body extends StatelessWidget {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading == false
          ? SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: (20),
                    vertical: (20),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (27),
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 90,
                      ),
                      Text(
                        "WELCOME BACK",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (15),
                        ),
                      ),
                      SizedBox(
                        height: 51,
                      ),
                      SignInForm(),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
