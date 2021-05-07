import 'package:fishiotfinal/login/splashscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0xffe9ebee),
            primaryColor: Colors.blue,
            accentColor: Colors.pinkAccent),
        title: 'FishIOT',
        home: SplashPage());
  }
}
