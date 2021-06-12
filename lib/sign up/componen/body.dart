import 'dart:ui';

import 'package:fam_church/sign%20up/componen/signup_form.dart';
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
                        "Register an account",
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
                        "Complete detials below or \ncontinue with social accounts",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (15),
                        ),
                      ),
                      SizedBox(
                        height: 51,
                      ),
                      SignUpForm(),
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
