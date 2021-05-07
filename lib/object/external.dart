// import 'package:finalproject/object/HexTime.dart';
// import 'package:finalproject/object/about.dart';
// import 'package:finalproject/screen/Tempsetup.dart';
// import 'package:finalproject/screen/Turbiditysetup.dart';
// // import 'package:finalproject/object/background.dart';
// import 'package:finalproject/screen/auto.dart';
// import 'package:finalproject/screen/manual.dart';
// import 'package:finalproject/screen/pHsetup.dart';
import 'package:fishiotfinal/object/HexTime.dart';
import 'package:fishiotfinal/object/about.dart';
import 'package:fishiotfinal/screen/Tempsetup.dart';
import 'package:fishiotfinal/screen/Turbiditysetup.dart';
import 'package:fishiotfinal/screen/pHsetup.dart';
// import 'package:finalproject/screen/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottonBar extends StatelessWidget {
  BottonBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Bottom that pops up from the bottom of the screen.
            IconButton(
              icon: Icon(Icons.blur_on),
              onPressed: () {
                showModalBottomSheet<Null>(
                  //
                  context: context,
                  builder: (BuildContext context) => Drawer(
                    child: Column(
                      children: <Widget>[
                        SimpleClock(),
                        SizedBox(
                          height: 20.0,
                        ),
                        // ManualBotton(),
                        SizedBox(
                          height: 20.0,
                        ),
                        // AutoBotton(),
                        SizedBox(
                          height: 20.0,
                        ),
                        AboutButton(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}

class AboutButton extends StatelessWidget {
  AboutButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoButton(
        color: Colors.redAccent[200],
        child: Text(
          'About',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          var route =
              MaterialPageRoute(builder: (BuildContext context) => AboutPage());
          Navigator.of(context).push(route);
        },
      ),
    );
  }
}

class BtnPH extends StatelessWidget {
  BtnPH({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoButton(
        color: Colors.greenAccent[100],
        child: Text(
          'PH',
          style: TextStyle(
            fontSize: 25,
            color: Colors.indigo[900],
            fontFamily: "circe",
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.white,
                offset: Offset(3, 3),
                blurRadius: 6,
              )
            ],
          ),
        ),
        onPressed: () {
          var route = MaterialPageRoute(
              builder: (BuildContext context) => DataPhSetup());
          Navigator.of(context).push(route);
        },
      ),
    );
  }
}

class BtnTurbidity extends StatelessWidget {
  BtnTurbidity({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoButton(
        color: Colors.brown[200],
        child: Text(
          'Turbidity',
          style: TextStyle(
            fontSize: 25,
            color: Colors.indigo[900],
            fontFamily: "circe",
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.white,
                offset: Offset(3, 3),
                blurRadius: 6,
              )
            ],
          ),
        ),
        onPressed: () {
          var route = MaterialPageRoute(
              builder: (BuildContext context) => DataTurbiditySetup());
          Navigator.of(context).push(route);
        },
      ),
    );
  }
}

class BtnTemp extends StatelessWidget {
  BtnTemp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoButton(
        color: Colors.redAccent[100],
        child: Text(
          'Temperature',
          style: TextStyle(
            fontSize: 25,
            color: Colors.indigo[900],
            fontFamily: "circe",
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.white,
                offset: Offset(3, 3),
                blurRadius: 6,
              )
            ],
          ),
        ),
        onPressed: () {
          var route = MaterialPageRoute(
              builder: (BuildContext context) => DataTemperatureSetup());
          Navigator.of(context).push(route);
        },
      ),
    );
  }
}

class ReadBeforeSet extends StatelessWidget {
  ReadBeforeSet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: Colors.cyan[400],
      onPressed: () {
        // ignore: missing_required_param
        showDialog(
            context: context,
            child: new AlertDialog(
              title: Column(
                children: <Widget>[
                  Text("Notice of \nPerfect Value\n"),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ],
              ),
              content: Text(
                  "PH Value\nMinimum XX.XX\nMaximum XX.XX\n\nTurbidity Value\nMinimum XX.XX\nMaximum XX.XX\n\nTemperature Value\nMinimum XX.XX\nMaximum XX.XX\n"),
              actions: <Widget>[
                // ignore: deprecated_member_use
                RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"))
              ],
            ));
      },
      child: Text(
        'Read Before Set Data',
        style: TextStyle(
          fontSize: 20,
          fontFamily: "circe",
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class AdvisorButton extends StatelessWidget {
  AdvisorButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: Colors.blueGrey,
      onPressed: () {
        // ignore: missing_required_param
        showDialog(
            context: context,
            // return object of type AlertDialog
            child: AlertDialog(
              title: Column(
                children: <Widget>[
                  SizedBox(height: 15.0),
                  // Text("Advisor"),
                  Text(
                    "Advisor",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.normal,
                      fontFamily: "circe",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15.0),
                  Icon(
                    Icons.done_all,
                    color: Colors.green,
                    size: 60,
                  ),
                ],
              ),
              content: //Text("Advisor"),
                  Text(
                "\n\nMr.Wanpracha Nuansoi \n Mrs.Wandee Nuansoi\n\n\n\nRUTS RPC\n\nRajamangala University of Technology Srivijaya Rattaphum College",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  // fontStyle: FontStyle.normal,
                  fontFamily: "circe",
                ),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Row(
                  children: <Widget>[
                    Wrap(
                      children: <Widget>[
                        // ignore: deprecated_member_use
                        RaisedButton(
                          color: Colors.pink[900],
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(context),
                            );
                          },
                          child: Text("About ICE"),
                        ),
                        SizedBox(width: 15.0),
                        // ignore: deprecated_member_use
                        RaisedButton(
                          color: Colors.pink[900],
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ));
      },
      child: Text(
        'Advisor and More',
        style: TextStyle(
          fontFamily: "circe",
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    content: Column(
      children: <Widget>[
        // SizedBox(height: 15.0),
        Icon(
          Icons.done_all,
          color: Colors.green,
          size: 60,
        ),
        SizedBox(height: 15.0),
        Text(
          "Related  Advisors",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            // fontStyle: FontStyle.normal,
            fontFamily: "circe",
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 25.0),
        Text(
          "Mr.Wanpracha Nuansoi\nMain Advisors Support Hardware And Project Tools\nCoding Helper And Budget \n\nMr.Suppachai  Maduea\nLayout Design And \nGuided Hardware Project Commentation  \n\nMrs.Supawadee Mak-on\nSupport Teaching Coding And IoT Guidelines",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // fontStyle: FontStyle.normal,
            fontFamily: "circe",
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 15.0),
      ],
    ),
    actions: <Widget>[
      // ignore: deprecated_member_use
      RaisedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: Text('Close'),
      ),
    ],
  );
}
