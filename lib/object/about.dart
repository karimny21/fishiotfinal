// import 'package:finalproject/login/auth.dart';
// import 'package:finalproject/object/buttonbar.dart';
import 'package:fishiotfinal/login/LocalAuth.dart';
import 'package:fishiotfinal/object/external.dart';

import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Main Support",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
        ),
        actions: <Widget>[Logoutbutton()],
      ),
      bottomNavigationBar: BottonBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                height: MediaQuery.of(context).size.height * 0.35,
                child: Card(
                  color: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 8,
                  child: Container(
                    child: Center(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentUserText extends StatelessWidget {
  const CurrentUserText({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final AboutPage widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Thank You',
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic),
    );
  }
}

class Logoutbutton extends StatelessWidget {
  const Logoutbutton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Text(
          "LOGOUT",
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LocalAuth()));
        });
  }
}
