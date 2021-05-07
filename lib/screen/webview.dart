// import 'package:finalproject/object/HexTime.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_native_web/flutter_native_web.dart';

// class GraphControl extends StatefulWidget {
//   final FirebaseUser currentUser;

//   const GraphControl({Key key, this.currentUser}) : super(key: key);
//   // GraphControl(this.currentUser);

//   @override
//   _GraphControlState createState() => _GraphControlState();
// }

// class _GraphControlState extends State<GraphControl> {
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
//   final formKey = GlobalKey<FormState>();

//   WebController webControllerPh,
//       webControllerTurbidity,
//       webControllerTemperature;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations(
//         [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
//     FlutterNativeWeb flutterPh = new FlutterNativeWeb(
//       onWebCreated: onWebCreated,
//       gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//         Factory<OneSequenceGestureRecognizer>(
//           () => TapGestureRecognizer(),
//         ),
//       ].toSet(),
//     );

//     FlutterNativeWeb flutterTubidity = new FlutterNativeWeb(
//       onWebCreated: onWebCreatedTurbidity,
//       gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//         Factory<OneSequenceGestureRecognizer>(
//           () => TapGestureRecognizer(),
//         ),
//       ].toSet(),
//     );

//     FlutterNativeWeb flutterTemperature = new FlutterNativeWeb(
//       onWebCreated: onWebCreatedTemperature,
//       gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//         Factory<OneSequenceGestureRecognizer>(
//           () => TapGestureRecognizer(),
//         ),
//       ].toSet(),
//     );

//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             "Graph Control",
//             style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 fontStyle: FontStyle.normal),
//           ),
//           actions: [
//             SimpleClock(),
//           ],
//           bottom: TabBar(
//             isScrollable: true,
//             tabs: <Widget>[
//               Tab(text: 'Temperature'),
//               Tab(text: 'Tubidity'),
//               Tab(text: 'PH'),
//             ],
//           ),
//         ),
//         // bottomNavigationBar: BottonBar(),
//         body: TabBarView(
//           children: <Widget>[
//             Container(
//               // color: Colors.yellow
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: flutterTemperature,
//               ),
//               // height: 300.0,
//               // width: 300.0,
//             ),
//             Container(
//               // color: Colors.orange
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: flutterTubidity,
//               ),
//               // height: 300.0,
//               // width: 300.0,
//             ),
//             // Container(
//             //   color: Colors.red,
//             // ),
//             Container(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: flutterPh,
//               ),
//               // height: 300.0,
//               // width: 300.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void onWebCreated(webControllerPh) {
//     this.webControllerPh = webControllerPh;

//     this.webControllerPh.loadUrl(
//         'https://thingspeak.com/channels/1039081/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15');

//     this.webControllerPh.onPageStarted.listen((url) => print("Loading $url"));

//     this
//         .webControllerPh
//         .onPageFinished
//         .listen((url) => print("Finished loading $url"));
//   }

//   void onWebCreatedTurbidity(webControllerTurbidity) {
//     this.webControllerTurbidity = webControllerTurbidity;

//     this.webControllerTurbidity.loadUrl(
//         'https://thingspeak.com/channels/1039081/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15');

//     this
//         .webControllerTurbidity
//         .onPageStarted
//         .listen((url) => print("Loading $url"));
//     this
//         .webControllerTurbidity
//         .onPageStarted
//         .listen((url) => print("Loading $url"));

//     this
//         .webControllerTurbidity
//         .onPageFinished
//         .listen((url) => print("Finished loading $url"));
//   }

//   void onWebCreatedTemperature(webControllerTemperature) {
//     this.webControllerTemperature = webControllerTemperature;

//     this.webControllerTemperature.loadUrl(
//         'https://thingspeak.com/channels/1039081/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15');

//     this
//         .webControllerTemperature
//         .onPageStarted
//         .listen((url) => print("Loading $url"));
//     this
//         .webControllerTemperature
//         .onPageStarted
//         .listen((url) => print("Loading $url"));

//     this
//         .webControllerTemperature
//         .onPageFinished
//         .listen((url) => print("Finished loading $url"));
//   }

//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //       appBar: AppBar(
//   //         centerTitle: true,
//   //         title: Text(
//   //           "Graph Control",
//   //           style: TextStyle(
//   //               fontSize: 18,
//   //               fontWeight: FontWeight.bold,
//   //               fontStyle: FontStyle.normal),
//   //         ),
//   //         bottom: TabBar(
//   //           isScrollable: true,
//   //          tabs: <Widget>[
//   //             Tab(text: 'yellow'),
//   //             Tab(text: 'orange'),
//   //             Tab(text: 'red'),
//   //           ],
//   //           ),
//   //         actions: <Widget>[
//   //           SimpleClock(),
//   //         ], //Logoutbutton()
//   //       ),
//   //       // bottomNavigationBar: BottonBar(),
//   //       body: Wrap(
//   //         children: <Widget>[
//   //           // showTab(),
//   //           // showGraph(url1),
//   //         ],
//   //       ));
//   // }
// }

// // Widget showTab(){
// //   return MaterialApp(
// //     home: DefaultTabController(
// //       length: 3,
// //       child: Scaffold(
// //         appBar : AppBar(
// //           // title: Text("Show TabBar"),
// //           bottom: TabBar(
// //             tabs: <Widget>[
// //               Tab(text: 'Hello',),
// //               Tab(text: 'Hi'),
// //               Tab(text: 'Hey'),
// //             ]
// //             ),
// //           ),
// //       ),
// //       ),
// //   );
// // }

// // Widget showGraph(String urlString){
// //   return WebView(
// //     initialUrl: urlString,
// //     javascriptMode: JavascriptMode.unrestricted,
// //   );
// // }
