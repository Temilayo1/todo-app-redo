import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'splash/splash_screen.dart';

import 'tasks/tasks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool darkTheme = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noted',
      color: Colors.yellow,
      theme: darkTheme ? ThemeData.light() : ThemeData.dark(),

      // theme: ThemeData(
      //   darkThemeEnabled ? ThemeData.dark() : ThemeData.light(),
      // ),
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/tasks': (BuildContext context) => Tasks(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return SplashScreen();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
