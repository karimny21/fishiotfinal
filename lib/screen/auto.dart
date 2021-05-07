import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fishiotfinal/object/HexTime.dart';
import 'package:fishiotfinal/object/external.dart';
import 'package:fishiotfinal/screen/graphview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_native_web/flutter_native_web.dart';

class AutoControl extends StatefulWidget {
  final FirebaseUser currentUser;

  const AutoControl({Key key, this.currentUser}) : super(key: key);

  @override
  _AutoControlState createState() => _AutoControlState();
}

class _AutoControlState extends State<AutoControl> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final formKey = GlobalKey<FormState>();

  WebController webControllerPh,
      webControllerTurbidity,
      webControllerTemperature;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "FishIoT   (Auto Control)",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: "circe",
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
          ),
          actions: [
            SimpleClock(),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.deepPurple[900],
            tabs: <Widget>[
              Tab(text: 'All Graph View'),
              Tab(text: 'Setting'),
              Tab(text: 'About'),
            ],
            labelStyle: TextStyle(
              fontFamily: "circe",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            GraphMonitor(),
            Container(
              child: Wrap(
                children: <Widget>[
                  Card(
                      child: Form(
                    key: formKey,
                    child: Container(
                      padding: EdgeInsets.all(40.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Set Minimum \nand \nMaximum",
                              style: TextStyle(
                                fontFamily: 'circe',
                                fontSize: 36,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                shadows: [
                                  Shadow(
                                    color: Colors.lightBlueAccent,
                                    offset: Offset(3, 3),
                                    blurRadius: 6,
                                  )
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            // buttonSet(),
                            SizedBox(height: 20.0),
                            ReadBeforeSet(),
                            SizedBox(height: 30.0),
                            BtnPH(),
                            SizedBox(height: 30.0),
                            BtnTurbidity(),
                            SizedBox(height: 30.0),
                            BtnTemp(),
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25.0),
                  Text(
                    "Thank You!",
                    style: TextStyle(
                      fontFamily: 'circe',
                      fontSize: 36,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      shadows: [
                        Shadow(
                          color: Colors.blueGrey,
                          offset: Offset(3, 3),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "This App Use Only Combined with\nFish Aquarium Project",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: "circe",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Create By",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "circe",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Mr.Narongsak Yeemareb (Rim)\nMr.Somnuek Hatthawanno (Mint)\n\nIndustrial Computer Engineering\nICE 4/2   2563",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: "circe",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15.0),
                  SizedBox(height: 20.0),
                  AdvisorButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
