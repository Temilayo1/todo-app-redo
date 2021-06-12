import 'package:fam_church/reset%20password/components/body.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202124),
      appBar: AppBar(
        title: Text(
          "Forgot Password",
          style: TextStyle(
            color: Colors.white,
            fontSize: (25),
            //  fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
