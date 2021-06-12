import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (20),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Forgot Password",
                //  textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (40),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: (20),
              ),
              Text(
                "Please enter your email to recieve  \na link to reset your password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: (30),
                  //fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  late String email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {},
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: (30),
                ),
                child: Icon(
                  Icons.email_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("RESET"),
          ),
          SizedBox(
            height: 20,
          ),
          // NoAccount(),
        ],
      ),
    );
  }
}
