import 'package:fishiotfinal/login/LocalAuth.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 4,
        navigateAfterSeconds: LocalAuth(),
        title: Text(
          'Welcome to Fish IoT Control App\n\n             Wait a Minutes.....',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              fontFamily: "circe",
              color: Colors.limeAccent[700]),
        ),
        image: Image.asset('image/fish.png'),
        backgroundColor: Colors.black,
        styleTextUnderTheLoader: TextStyle(color: Colors.deepPurple),
        photoSize: 180.0,
        loaderColor: Colors.cyan[400]);
  }
}
