import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fishiotfinal/login/LocalAuth.dart';
import 'package:fishiotfinal/object/iotdata.dart';
import 'package:fishiotfinal/screen/auto.dart';
import 'package:fishiotfinal/screen/manual.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showSnack(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      duration: Duration(milliseconds: 180),
      backgroundColor: Colors.lightGreen[900],
    ));
  }

  void _showSnack2(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      duration: Duration(milliseconds: 180),
      backgroundColor: Colors.lightBlue[900],
    ));
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  bool modeBool = false, statusledBool = false;
  int modeInt = 0, statusInt = 0;
  String statusString = "Auto";

  IotModel iotModel;

  Future<void> editDatabase() async {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTMode');

    Map<dynamic, dynamic> map = Map();
    map['mode'] = modeInt;
    map['statusled'] = statusInt;
    map['currentMode'] = statusString;

    await databaseReference.set(map).then((response) {
      print('Edit Success');
    });
  }

  void checkSwitch() {
    setState(() {
      if (iotModel.mode == 0) {
        modeBool = false;
      } else {
        modeBool = true;
      }

      if (iotModel.statusled == 0) {
        statusledBool = false;
      } else {
        statusledBool = true;
      }
    });
    print('mode=$modeBool,statusled=$statusledBool,');
  }

  Widget bottonmode() {
    return Container(
      child: SizedBox(
        height: 50,
        width: 200,
        child: RaisedButton.icon(
          highlightColor: Colors.tealAccent,
          color: Colors.blueGrey[900],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () {
            setState(() {
              modeInt = modeInt;
              statusInt = statusInt;
              if (modeInt == 0) {
                modeInt = 1;
                // mode = "Auto";
                _showSnack("Auto");
              } else {
                modeInt = 0;
                // mode = "Manual";
                _showSnack2("Manual");
              }

              if (statusInt == 0) {
                statusInt = 1;
                statusString = 'Auto';
              } else {
                statusInt = 0;
                statusString = 'Manual';
              }

              print('$modeInt,$statusInt');
              editDatabase();
            });
          },
          icon: Icon(
            Icons.settings,
            color: Colors.cyanAccent[700],
          ),
          label: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: 'Mode  ',
                style: TextStyle(
                    fontFamily: "circe",
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    color: Colors.cyanAccent),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Timer _evertSecond;
  int status = 0, prevstatus = 0, count = 0;

  @override
  void initState() {
    super.initState();
    getValue();
    getMode();
    getStatus();
    _evertSecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (prevstatus != status) {
        showStatus = "ONLINE";
        count++;
        if (count >= 30) {
          count = 0;
          prevstatus = status;
        } else if (prevstatus == status) {
          showStatus = "RECONNECT";
        }
      }
      print("praveValue : ");
      print(prevstatus);
      print("status : ");
      print(status);
      print("Count");
      print(count);
    });
  }

  int sCheck, sCheck1, sCheck3;
  String showStatus;

  Future<void> getStatus() async {
    final dbRefer = FirebaseDatabase.instance.reference();
    dbRefer.child('IoTModeStatus').onValue.listen((event) {
      var snapshot = event.snapshot;
      Map<dynamic, dynamic> value = snapshot.value;

      setState(() {
        status = value['onchange']['get'];
        // if (prevstatus != status) {
        //   showStatus = "ONLINE";
        //   prevstatus = status;
        // } else {
        //   showStatus = "OFFLINE";
        // }
        print("praveValue : ");
        print(prevstatus);
        print("status : ");
        print(status);
      });
    });
  }

  double getPH, getTubidity;
  int getTemp;

  Future<void> getValue() async {
    final dbRefer = FirebaseDatabase.instance.reference();
    dbRefer.child('IoT').onValue.listen((event) {
      var snapshot = event.snapshot;
      Map<dynamic, dynamic> value = snapshot.value;
      setState(() {
        getPH = value['phSensor'];
        getTubidity = value['turbiditySensor'];
        getTemp = value['temperature'];

        print('\tPH = $getPH, Tur = $getTubidity, Temp = $getTemp');
      });
    });
  }

  String currentMode;

  var status1 = true, status2 = true;

  Future<void> getMode() async {
    final dbRefer = FirebaseDatabase.instance.reference();
    dbRefer.child('IoTMode').onValue.listen((event) {
      var snapshot = event.snapshot;
      Map<dynamic, dynamic> value = snapshot.value;
      setState(() {
        currentMode = value['currentMode'];

        if (currentMode == "Auto") {
          status1 = true;
          print("Mode Auto");
        } else {
          status1 = false;
          print("Mode Manual");
        }

        if (currentMode == "Manual") {
          status2 = true;
          print("Mode Auto");
        } else {
          status2 = false;
          print("Mode Manual");
        }

        print('\tMode = $currentMode');
      });
    });
  }

  void realTime() {
    print('Test');
  }

  Widget manualButton() {
    return Container(
      child: CupertinoButton(
        color: Colors.limeAccent,
        disabledColor: Colors.grey[300],
        child: Text(
          'Manual Control',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'circe',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            shadows: [
              Shadow(
                color: Colors.white,
                offset: Offset(3, 3),
                blurRadius: 6,
              )
            ],
          ),
        ),
        onPressed: status2
            ? () {
                var route = MaterialPageRoute(
                    builder: (BuildContext context) => ManualControl());
                Navigator.of(context).push(route);
              }
            : null,
      ),
    );
  }

  Widget autoManual() {
    return Container(
      child: CupertinoButton(
        color: Colors.lightBlue[200],
        disabledColor: Colors.grey[300],
        child: Text(
          'Automatic Control',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'circe',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            shadows: [
              Shadow(
                color: Colors.white,
                offset: Offset(3, 3),
                blurRadius: 6,
              )
            ],
          ),
        ),
        onPressed: status1
            ? () {
                var route = MaterialPageRoute(
                    builder: (BuildContext context) => AutoControl());
                Navigator.of(context).push(route);
              }
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          // ignore: unnecessary_brace_in_string_interps
          "Welcome",
          style: TextStyle(
            fontFamily: 'circe',
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            shadows: [
              Shadow(
                color: const Color(0x290a0a0a),
                offset: Offset(0, 3),
                blurRadius: 6,
              )
            ],
          ),
        ),
        actions: <Widget>[Logoutbutton()],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50.0),
            Text(
              "Choose Menu",
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
            ),
            SizedBox(height: 20.0),
            Card(
              clipBehavior: Clip.antiAlias,
              child: Container(
                padding: EdgeInsets.all(40.0),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        manualButton(),
                        SizedBox(height: 30.0),
                        autoManual(),
                        SizedBox(height: 30.0),
                        SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            bottonmode(),
                            CupertinoButton(
                              child: Text(
                                '  $currentMode',
                                style: TextStyle(
                                  color: Colors.purpleAccent[700],
                                  fontFamily: 'circe',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  shadows: [
                                    Shadow(
                                      color: Colors.white,
                                      offset: Offset(3, 3),
                                      blurRadius: 6,
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              width: 300,
              height: 140,
              child: Card(
                color: Colors.black,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Wrap(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'PH :  ',
                                        style: TextStyle(
                                            fontFamily: "circe",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 22.0)),
                                    TextSpan(
                                        text: '$getPH',
                                        style: TextStyle(
                                            fontFamily: "circe",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22.0,
                                            color: Colors.lightGreenAccent)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Turbidity :  ',
                                        style: TextStyle(
                                            fontFamily: "circe",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 22.0)),
                                    TextSpan(
                                        text: '$getTubidity',
                                        style: TextStyle(
                                            fontFamily: "circe",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22.0,
                                            color: Colors.orange[100])),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Temperature :  ',
                                        style: TextStyle(
                                            fontFamily: "circe",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 22.0)),
                                    TextSpan(
                                        text: '$getTemp',
                                        style: TextStyle(
                                            fontFamily: "circe",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0,
                                            color: Colors.redAccent[400])),
                                    TextSpan(
                                      text: ' c',
                                      style: TextStyle(
                                          fontFamily: "circe",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0,
                                          color: Colors.redAccent[400]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              height: 80,
              child: Card(
                color: Colors.black,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Wrap(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Status :  ',
                                        style: TextStyle(
                                            fontFamily: "circe",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 22.0)),
                                    TextSpan(
                                        text: '$showStatus',
                                        style: TextStyle(
                                            fontFamily: "circe",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0,
                                            color: Colors.amberAccent[100])),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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

class Logoutbutton extends StatelessWidget {
  const Logoutbutton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: Colors.pinkAccent,
        splashColor: Colors.black38,
        child: Text(
          "LOGOUT",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "circe",
            fontWeight: FontWeight.w800,
          ),
        ),
        onPressed: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LocalAuth()));
        });
  }
}
