import 'package:fam_church/provider/auth_provider.dart';
import 'package:fam_church/sign-in/sign_in.dart';

import 'package:fam_church/tasks/tasks.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  final emailControllerr = TextEditingController();
  final passwordController = TextEditingController();
  bool isInputValid = false;
  bool remember = false;
  bool isLoading = false;
  final List<String> errors = [];
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: (30)),
          buildPasswordFormField(),
          SizedBox(
            height: (20),
          ),
          //
          SizedBox(
            height: 15,
          ),

          InkWell(
            onTap: () {
              setState(() {
                isLoading = true;
              });
              AuthClass()
                  .createAccount(
                      email: emailControllerr.text.trim(),
                      password: passwordController.text.trim())
                  .then(
                (value) {
                  if (value == "Account created") {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Tasks()),
                        (route) => false);
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(value)));
                  }
                },
              );
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "SIGN UP",
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
                color: !isInputValid ? Colors.grey : Colors.red,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            },
            child: Text(
              "Create an account",
              style: TextStyle(
                color: Colors.blue,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SocialCards(
          //       icon: "assets/icons/facebook.svg",
          //       press: () {},
          //     ),
          //     SocialCards(
          //       icon: "assets/icons/google.svg",
          //       press: () {},
          //     ),
          //
          //   ],
          // ),

          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: _isHidden,
      onChanged: (value) {
        // if (passwordController.text.length > 0) {
        //   setState(() {
        //     isInputValid = true;
        //   });
        // } else if (isInputValid = false) ;
      },
      validator: (value) {},
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        fillColor: Colors.grey,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.teal),
        ),
        hintText: "Enter password",
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: (15),
          // fontWeight: FontWeight.bold,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (30),
          ),
          child: InkWell(
            onTap: _togglePasswordView,
            child: Icon(
              Icons.visibility,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailControllerr,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) {},
      onChanged: (value) {},
      validator: (value) {},
      decoration: InputDecoration(
        fillColor: Colors.grey,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        // labelText: "Email",
        // labelStyle: TextStyle(color: Colors.blue),
        hintText: "Enter email",
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: (15),
          //   fontWeight: FontWeight.bold,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (30),
          ),
          child: Icon(
            Icons.email_outlined,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}

final RegExp emailvalidatorRegExp =
    RegExp(r"^[a-zA-Z0-9,]+@[a-zA-Z0-9,]+\.[a-zA-Z])+");
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Please enter a valid email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password too short";
const String kMatchPassError = "Passwords don't match";
