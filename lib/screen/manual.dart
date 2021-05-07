import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fishiotfinal/object/HexTime.dart';
import 'package:fishiotfinal/object/iotdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ManualControl extends StatefulWidget {
  final FirebaseUser currentUser;

  const ManualControl({Key key, this.currentUser}) : super(key: key);

  @override
  _ManualControlState createState() => _ManualControlState();
}

class _ManualControlState extends State<ManualControl> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final formKey = GlobalKey<FormState>();

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
      backgroundColor: Colors.red[900],
    ));
  }

  bool ledBool = false, waterBool = false, foodBool = false, airBool = false;
  int ledInt = 0, waterInt = 0, foodInt = 0, airInt = 0;

  String ledText = "",
      waterText = "",
      foodText = "",
      setPh = '',
      setTur = '',
      setTemp = '';

  IoTData ioTData;
  IotModel iotModel;

  @override
  void initState() {
    super.initState();
    readDatabase();
    getIntLED();
    getIntWater();
    getIntFood();
  }

  Future<void> readDatabase() async {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTSet');
    await databaseReference.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        iotModel = IotModel.formMap(dataSnapshot.value);
        ledText = iotModel.setled.toString();
        waterText = iotModel.setwater.toString();
        foodText = iotModel.setfood.toString();
      });
    });
  }

  Future<void> sentIntLED() async {
    FirebaseDatabase.instance.reference();
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTModule/led');
    Map<dynamic, dynamic> map = Map();
    map['sled'] = ledInt;

    await databaseReference.set(map).then((response) {
      print('Edit Success');
    });
  }

  Future<void> sentIntWater() async {
    FirebaseDatabase.instance.reference();
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTModule/water');
    Map<dynamic, dynamic> map = Map();
    map['swater'] = waterInt;

    await databaseReference.set(map).then((response) {
      print('Edit Success');
    });
  }

  Future<void> sentIntFood() async {
    FirebaseDatabase.instance.reference();
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTModule/food');
    Map<dynamic, dynamic> map = Map();
    map['sfood'] = foodInt;
    await databaseReference.set(map).then((response) {
      print('Edit Success');
    });
  }

  bool checkSpace(String value) {
    bool result = false;
    if (value.length == 0) {
      result = true;
    }
    return result;
  }

  int nled, nwater, nfood;
  String sLed = "Close", sWater = "Close", sFood = "Close";

  Future<void> getIntLED() async {
    final dbPull = FirebaseDatabase.instance.reference();
    dbPull.child('IoTModule/led').onValue.listen((event) {
      var snapshot = event.snapshot;
      Map<dynamic, dynamic> value = snapshot.value;
      setState(() {
        nled = value['sled'];
        if (nled == 0) {
          sLed = "Close";
        } else if (nled == 1) {
          sLed = "Open";
        }
      });
    });
  }

  Future<void> getIntWater() async {
    final dbPull = FirebaseDatabase.instance.reference();
    dbPull.child('IoTModule/water').onValue.listen((event) {
      var snapshot = event.snapshot;
      Map<dynamic, dynamic> value = snapshot.value;
      setState(() {
        nwater = value['swater'];
        if (nwater == 0) {
          sWater = "Close";
        } else if (nwater == 1) {
          sWater = "Open";
        }
      });
    });
  }

  Future<void> getIntFood() async {
    final dbPull = FirebaseDatabase.instance.reference();
    dbPull.child('IoTModule/food').onValue.listen((event) {
      var snapshot = event.snapshot;
      Map<dynamic, dynamic> value = snapshot.value;
      setState(() {
        nfood = value['sfood'];
        if (nfood == 0) {
          sFood = "Close";
        } else if (nfood == 1) {
          sFood = "Open";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "FishIoT (Manual Control)",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "circe",
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            SimpleClock(),
          ],
        ),
        body: Center(
          child: Wrap(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "Manual Control\nSwitch Devices",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontFamily: "circe",
                            color: Colors.black),
                      ),
                    ]),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    child: Form(
                        key: formKey,
                        child: Container(
                          child: Wrap(children: <Widget>[
                            Card(
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                padding: EdgeInsets.all(40.0),
                                child: Column(
                                  children: <Widget>[
                                    ledButton(),
                                    SizedBox(height: 10.0),
                                    RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: 'LED :   ',
                                            style: TextStyle(
                                                fontFamily: "circe",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22.0,
                                                color: Colors.lime[900])),
                                        TextSpan(
                                            text: '$sLed',
                                            style: TextStyle(
                                                fontFamily: "circe",
                                                fontWeight: FontWeight.w800,
                                                fontSize: 22.0,
                                                color: Colors.black87)),
                                      ]),
                                    ),
                                    SizedBox(height: 40.0),
                                    waterButton(),
                                    SizedBox(height: 10.0),
                                    RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: 'Water :   ',
                                            style: TextStyle(
                                                fontFamily: "circe",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22.0,
                                                color: Colors.blue[900])),
                                        TextSpan(
                                            text: '$sWater',
                                            style: TextStyle(
                                                fontFamily: "circe",
                                                fontWeight: FontWeight.w800,
                                                fontSize: 22.0,
                                                color: Colors.black87)),
                                      ]),
                                    ),
                                    SizedBox(height: 40.0),
                                    foodButton(),
                                    SizedBox(height: 10.0),
                                    RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: 'Food :   ',
                                            style: TextStyle(
                                                fontFamily: "circe",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22.0,
                                                color: Colors.brown[800])),
                                        TextSpan(
                                            text: '$sFood',
                                            style: TextStyle(
                                                fontFamily: "circe",
                                                fontWeight: FontWeight.w800,
                                                fontSize: 22.0,
                                                color: Colors.black87)),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget ledButton() {
    return Container(
      child: SizedBox(
        height: 80,
        width: 230,
        child: RaisedButton.icon(
          textColor: Colors.lime[900],
          color: Colors.limeAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          onPressed: () {
            setState(() {
              ledInt = ledInt;
              if (ledInt == 0) {
                ledInt = 1;
                ledText = "Open";
                _showSnack("LED Open");
              } else {
                ledInt = 0;
                ledText = "Close";
                _showSnack2("LED Close");
              }
              print('$ledInt');
              sentIntLED();
            });
          },
          icon: Icon(Icons.lightbulb_outline, size: 50),
          label: Text(""),
        ),
      ),
    );
  }

  Widget waterButton() {
    return Container(
      child: SizedBox(
        height: 80,
        width: 230,
        child: RaisedButton.icon(
          textColor: Colors.blue[900],
          color: Colors.lightBlueAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          onPressed: () {
            setState(() {
              waterInt = waterInt;
              if (waterInt == 0) {
                waterInt = 1;
                waterText = "Open";
                _showSnack("Water Open");
              } else {
                waterInt = 0;
                waterText = "Close";
                _showSnack2("Water Close");
              }
              print('$waterInt');
              sentIntWater();
            });
          },
          icon: Icon(
            Icons.invert_colors,
            size: 50,
          ),
          label: Text(""),
        ),
      ),
    );
  }

  Widget foodButton() {
    return Container(
      child: SizedBox(
        height: 80,
        width: 230,
        child: RaisedButton.icon(
          textColor: Colors.black,
          color: Colors.brown[200],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          onPressed: () {
            setState(() {
              foodInt = foodInt;
              if (foodInt == 0) {
                foodInt = 1;
                foodText = "Open";
                _showSnack("Food Open");
              } else {
                foodInt = 0;
                foodText = "Close";
                _showSnack2("Food Close");
              }
              print('$foodInt');
              sentIntFood();
            });
          },
          icon: Icon(
            Icons.restaurant_menu,
            size: 50,
          ),
          label: Text(""),
        ),
      ),
    );
  }
}
