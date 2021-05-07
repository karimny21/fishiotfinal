import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fishiotfinal/object/iotdata.dart';
import 'package:fishiotfinal/object/my_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DataPhSetup extends StatefulWidget {
  final FirebaseUser currentUser;

  const DataPhSetup({Key key, this.currentUser}) : super(key: key);

  @override
  _DataPhSetupState createState() => _DataPhSetupState();
}

class _DataPhSetupState extends State<DataPhSetup> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final formKey = GlobalKey<FormState>();

  String maxPh = '', minPh = '';

  IoTPH ioTPH;

  @override
  void initState() {
    super.initState();
    readDatabase();
    getValuePH();
  }

  Future<void> readDatabase() async {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTSet/PhValue');
    await databaseReference.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        ioTPH = IoTPH.formMap(dataSnapshot.value);
        maxPh = ioTPH.maxPh.toString();
        minPh = ioTPH.minPh.toString();
        //setTemp = ioTAuto.setTemp.toString();
      });
    });
  }

  void updatedata(BuildContext context) async {
    print('maxPh = $maxPh \nminPh = $minPh '); //\nsetTemp = $setTemp\n
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTSet');
    await databaseReference.once().then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> map = dataSnapshot.value;
      print('map = $map');
      map['maxPh'] = maxPh;
      map['minPh'] = minPh;
      // map['setTemp'] = setTemp;
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
    print('maxPh : $maxPh,minPh : $minPh');
    IoTPH ioTAuto = IoTPH(
      int.parse(maxPh),
      int.parse(minPh),
    );

    Map map = ioTAuto.toMap();

    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoTSet/PhValue');
    await databaseReference.set(map).then((response) {});
  }

  bool checkSpace(String value) {
    bool result = false;
    if (value.length == 0) {
      result = true;
    }
    return result;
  }

  double getPH;

  Future<void> getValuePH() async {
    final databaseReferenceTest = FirebaseDatabase.instance.reference();
    databaseReferenceTest.child('IoT').onValue.listen((event) {
      var snapshot = event.snapshot;
      Map<dynamic, dynamic> value = snapshot.value;
      setState(() {
        getPH = value['phSensor'];
        print('\tPH = $getPH');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pH Setup'),
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
                        "Set Value Of PH",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontFamily: "circe",
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30.0),
                      textfieldMaxPH(),
                      SizedBox(height: 30.0),
                      textfieldMinPH(),
                      SizedBox(height: 30.0),
                      buttonSet(),
                      SizedBox(height: 30.0),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'PH :  ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "circe",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 22.0)),
                            TextSpan(
                                text: '$getPH',
                                style: TextStyle(
                                    fontFamily: "circe",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 22.0,
                                    color: Colors.lightGreen[900])),
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

  Widget textfieldMaxPH() {
    return Container(
      child: TextFormField(
        initialValue: maxPh,
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
          labelText: 'Maximum Of pH',
          suffixText: 'Original : $maxPh',
          suffixStyle: TextStyle(
            color: Colors.green[900],
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
            maxPh = value.trim();
          }
        },
      ),
    );
  }

  Widget textfieldMinPH() {
    return Container(
      child: TextFormField(
        initialValue: minPh,
        inputFormatters: [LengthLimitingTextInputFormatter(2)],
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Colors.greenAccent[700],
            fontWeight: FontWeight.w900,
            fontFamily: 'circe'),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(),
          prefixIcon: Icon(Icons.tag_faces),
          labelText: 'Minimum Of pH',
          suffixText: 'Original : $minPh',
          suffixStyle: TextStyle(
            color: Colors.green[900],
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
            minPh = value.trim();
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
                    "Done! \n\nYou Set\n\nPh: $maxPh\nTur: $minPh\n\nSent To Cloud",
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
