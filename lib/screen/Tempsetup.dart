import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fishiotfinal/object/iotdata.dart';
import 'package:fishiotfinal/object/my_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';

class DataTemperatureSetup extends StatefulWidget {
  final FirebaseUser currentUser;

  const DataTemperatureSetup({Key key, this.currentUser}) : super(key: key);

  @override
  _DataTemperatureSetupState createState() => _DataTemperatureSetupState();
}

class _DataTemperatureSetupState extends State<DataTemperatureSetup> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final formKey = GlobalKey<FormState>();

  String maxTemp = '', minTemp = '';

  IoTTemp ioTTemp;

  @override
  void initState() {
    super.initState();
    readDatabase();
    getValueTemp();
  }

  Future<void> readDatabase() async {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTSet/TempValue');
    await databaseReference.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        ioTTemp = IoTTemp.formMap(dataSnapshot.value);
        maxTemp = ioTTemp.maxTemp.toString();
        minTemp = ioTTemp.minTemp.toString();
      });
    });
  }

  void updatedata(BuildContext context) async {
    print('maxTemp = $maxTemp \nminTemp = $minTemp ');
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTSet');
    await databaseReference.once().then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> map = dataSnapshot.value;
      print('map = $map');
      map['maxTemp'] = maxTemp;
      map['minTemp'] = minTemp;
      print('map current = $map');
      sentdata(map, context);
    });
  }

  void sentdata(Map map, BuildContext context) async {
    await firebaseDatabase
        .reference()
        .child('IoTSet')
        .set(map)
        .then((objValue) {
      print('Success');
    }).catchError((objValue) {});
  }

  Future<void> editDatabase() async {
    print('maxTemp : $maxTemp,minTempbidity : $minTemp'); //,setTemp = $setTemp
    IoTTemp ioTTemp = IoTTemp(
      int.parse(maxTemp),
      int.parse(minTemp),
    );

    Map map = ioTTemp.toMap();
    // print('map = $map');
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTSet/TempValue');
    await databaseReference.set(map).then((response) {
      // readDatabase();
    });
  }

  bool checkSpace(String value) {
    bool result = false;
    if (value.length == 0) {
      result = true;
    }
    return result;
  }

  int getTemp;

  Future<void> getValueTemp() async {
    final databaseReferenceTest = FirebaseDatabase.instance.reference();
    databaseReferenceTest.child('IoT').onValue.listen((event) {
      var snapshot = event.snapshot;
      Map<dynamic, dynamic> value = snapshot.value;
      setState(() {
        getTemp = value['temperature'];
        print(' Temp = $getTemp');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Setup'),
        actions: <Widget>[],
      ),
      body: Center(
        child: Wrap(
          children: <Widget>[
            Container(
              child: Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.all(50.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Set Value Of \nTemperature",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontFamily: "circe",
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50.0),
                      textfieldMaxTemp(),
                      SizedBox(height: 30.0),
                      textfieldMinTemp(),
                      // SizedBox(height: 30.0),
                      // textfieldTemp(),
                      SizedBox(height: 30.0),
                      buttonSet(),
                      SizedBox(height: 30.0),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Temperature :  ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "circe",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 22.0)),
                            TextSpan(
                                text: '$getTemp',
                                style: TextStyle(
                                    fontFamily: "circe",
                                    fontWeight: FontWeight.w900,
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
                ),
              ),
            ),
            // ),
            // ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget textfieldMaxTemp() {
    return Container(
      child: TextFormField(
        initialValue: maxTemp,
        inputFormatters: [LengthLimitingTextInputFormatter(2)],
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Colors.lightBlue,
            fontWeight: FontWeight.w900,
            fontFamily: 'circe'),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(),
          prefixIcon: Icon(Icons.tag_faces),
          labelText: 'Maximum Of Temp',
          suffixText: 'Original : $maxTemp',
          suffixStyle: TextStyle(
            color: Colors.red[900],
            fontFamily: 'circe',
            fontWeight: FontWeight.w900,
          ),
          helperStyle: Mystyle().styleset,
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        ),
        // ignore: missing_return
        validator: (String value) {
          if (checkSpace(value)) {
            return;
          }
        },
        onSaved: (String value) {
          if (value.isNotEmpty) {
            maxTemp = value.trim();
          }
        },
      ),
    );
  }

  Widget textfieldMinTemp() {
    return Container(
      child: TextFormField(
        initialValue: minTemp,
        inputFormatters: [LengthLimitingTextInputFormatter(2)],
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Colors.greenAccent,
            fontWeight: FontWeight.w900,
            fontFamily: 'circe'),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(),
          prefixIcon: Icon(Icons.tag_faces),
          labelText: 'Minimum Of Temp',
          suffixText: 'Original : $minTemp',
          suffixStyle: TextStyle(
            color: Colors.red[900],
            fontFamily: 'circe',
            fontWeight: FontWeight.w900,
          ),
          helperStyle: Mystyle().styleset,
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        ),

        // ignore: missing_return
        validator: (String value) {
          if (checkSpace(value)) {
            return;
          }
        },
        onSaved: (String value) {
          if (value.isNotEmpty) {
            minTemp = value.trim();
          }
        },
      ),
    );
  }

  Widget buttonSet() {
    return Container(
      child: CupertinoButton(
        color: Colors.cyan,
        child: Text('Set',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontFamily: 'circe')),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            editDatabase();
            Fluttertoast.showToast(
                msg:
                    "Done! \n\nYou Set\n\nPh: $maxTemp\nTur: $minTemp\n\nSent To Cloud",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.cyanAccent[100],
                textColor: Colors.black,
                timeInSecForIosWeb: 1);
          }
        },
      ),
    );
  }
}
