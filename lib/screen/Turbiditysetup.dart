import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fishiotfinal/object/iotdata.dart';
import 'package:fishiotfinal/object/my_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';

class DataTurbiditySetup extends StatefulWidget {
  final FirebaseUser currentUser;

  const DataTurbiditySetup({Key key, this.currentUser}) : super(key: key);

  @override
  _DataTurbiditySetupState createState() => _DataTurbiditySetupState();
}

class _DataTurbiditySetupState extends State<DataTurbiditySetup> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final formKey = GlobalKey<FormState>();

  String maxTurbidity = '', minTurbidity = '';

  IoTTurbidity ioTTurbidity;

  @override
  void initState() {
    super.initState();
    readDatabase();
    getValueTur();
  }

  Future<void> readDatabase() async {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTSet/TurbidityValue');
    await databaseReference.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        ioTTurbidity = IoTTurbidity.formMap(dataSnapshot.value);
        maxTurbidity = ioTTurbidity.maxTurbidity.toString();
        minTurbidity = ioTTurbidity.minTurbidity.toString();
      });
    });
  }

  void updatedata(BuildContext context) async {
    print('maxTurbidity = $maxTurbidity \nminTurbidity = $minTurbidity ');
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTSet');
    await databaseReference.once().then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> map = dataSnapshot.value;
      print('map = $map');
      map['maxTurbidity'] = maxTurbidity;
      map['minTurbidity'] = minTurbidity;
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
    print('maxTurbidity : $maxTurbidity,minTurbiditybidity : $minTurbidity');
    IoTTurbidity ioTTurbidity = IoTTurbidity(
      int.parse(maxTurbidity),
      int.parse(minTurbidity),
    );

    Map map = ioTTurbidity.toMap();

    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTSet/TurbidityValue');
    await databaseReference.set(map).then((response) {});
  }

  bool checkSpace(String value) {
    bool result = false;
    if (value.length == 0) {
      result = true;
    }
    return result;
  }

  double getTubidity;

  Future<void> getValueTur() async {
    final databaseReferenceTest = FirebaseDatabase.instance.reference();
    databaseReferenceTest.child('IoT').onValue.listen((event) {
      var snapshot = event.snapshot;
      Map<dynamic, dynamic> value = snapshot.value;
      setState(() {
        getTubidity = value['turbiditySensor'];
        print('Tur = $getTubidity');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turbidity Setup'),
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
                        "Set Value Of Turbidity",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontFamily: "circe",
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50.0),
                      textfieldMaxTurbidity(),
                      SizedBox(height: 30.0),
                      textfieldMinTurbidity(),
                      SizedBox(height: 30.0),
                      buttonSet(),
                      SizedBox(height: 30.0),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Turbidity :  ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "circe",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 22.0)),
                            TextSpan(
                                text: '$getTubidity',
                                style: TextStyle(
                                    fontFamily: "circe",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 22.0,
                                    color: Colors.amber[900])),
                          ],
                        ),
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

  Widget textfieldMaxTurbidity() {
    return Container(
      child: TextFormField(
        initialValue: maxTurbidity,
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
          labelText: 'Maximum Of Turbidity',
          suffixText: 'Original : $maxTurbidity',
          suffixStyle: TextStyle(
            color: Colors.indigo[900],
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
            maxTurbidity = value.trim();
          }
        },
      ),
    );
  }

  Widget textfieldMinTurbidity() {
    return Container(
      child: TextFormField(
        initialValue: minTurbidity,
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
          labelText: 'Minimum Of Turbidity',
          // helperText: 'Enter minTurbidity',
          // helperText: 'Set : $minTurbidity',
          suffixText: 'Original : $minTurbidity',
          suffixStyle: TextStyle(
            color: Colors.indigo[900],
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
            minTurbidity = value.trim();
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
                    "Done! \n\nYou Set\n\nPh: $maxTurbidity\nTur: $minTurbidity\n\nSent To Cloud", //Temp: $setTemp \n
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
