import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedFlutterLogo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AnimatedFlutterLogoState();
}

class _AnimatedFlutterLogoState extends State<AnimatedFlutterLogo> {
  Timer _timer;
  FlutterLogoStyle _logoStyle = FlutterLogoStyle.markOnly;

  _AnimatedFlutterLogoState() {
    Future.delayed(Duration(milliseconds: 100), () {
      
    });
  }

  // _AnimatedFlutterLogoState() {
  //   _timer = new Timer(const Duration(milliseconds: 1000), () {
  //     setState(() {
  //       _logoStyle = FlutterLogoStyle.horizontal;
  //     });
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new FlutterLogo(
      size: 200.0,
      textColor: Colors.white,
      style: _logoStyle,
    );
  }
}

// import 'package:flutter/material.dart';

// class SwitchWidget extends StatefulWidget {
//   @override
//   SwitchWidgetClass createState() => new SwitchWidgetClass();
// }

// class SwitchWidgetClass extends State {
//   bool switchControl = false;
//   var textHolder = 'Switch is On';

//   void toggleSwitch(bool value) {
//     if (switchControl == false) {
//       setState(() {
//         switchControl = true;
//         textHolder = 'Switch is Off';
//       });
//       print('Switch is Off');
//       // Put your code here which you want to execute on Switch ON event.

//     } else {
//       setState(() {
//         switchControl = false;
//         textHolder = 'Switch is On';
//       });
//       print('Switch is On');
//       // Put your code here which you want to execute on Switch OFF event.
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notification'),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//       ),
//       body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//         Container(
//           padding: EdgeInsets.only(top: 30),
//           child: Center(
//             child: Transform.scale(
//                 scale: 1.5,
//                 child: Switch(
//                   onChanged: toggleSwitch,
//                   value: switchControl,
//                   activeColor: Colors.black,
//                   activeTrackColor: Colors.grey,
//                   inactiveThumbColor: Colors.black,
//                   inactiveTrackColor: Colors.black,
//                 )),
//           ),
//         ),
//         Container(
//           child: Center(
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: Text(
//                     'Switch is OFF',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     'Switch is On',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10.0,
//         ),
//         Text(
//           '$textHolder',
//           style: TextStyle(fontSize: 20),
//         )
//       ]),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class SwitchWidget extends StatefulWidget {
//   @override
//   SwitchWidgetClass createState() => new SwitchWidgetClass();
// }

// class SwitchWidgetClass extends State {
//   bool switchControl = false;
//   var textHolder = 'Switch is OFF';

//   void toggleSwitch(bool value) {
//     if (switchControl == false) {
//       setState(() {
//         switchControl = true;
//         textHolder = 'Switch is ON';
//       });
//       print('Switch is ON');
//       // Put your code here which you want to execute on Switch ON event.

//     } else {
//       setState(() {
//         switchControl = false;
//         textHolder = 'Switch is OFF';
//       });
//       print('Switch is OFF');
//       // Put your code here which you want to execute on Switch OFF event.
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//       Transform.scale(
//           scale: 1.0,
//           child: Switch(
//             onChanged: toggleSwitch,
//             value: switchControl,
//             activeColor: Colors.blue,
//             activeTrackColor: Colors.green,
//             inactiveThumbColor: Colors.white,
//             inactiveTrackColor: Colors.grey,
//           )),
//       Text(
//         '$textHolder',
//         style: TextStyle(fontSize: 24),
//       )
//     ]);
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class FlutterExample extends StatefulWidget {
//   FlutterExample({Key key}) : super(key: key);

//   @override
//   _FlutterExampleState createState() => _FlutterExampleState();
// }

// class _FlutterExampleState extends State<FlutterExample> {
//   var status = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Enable / Disable Button'),
//       ),
//       body: Center(
//           child: Column(
//         children: [
//           CupertinoButton(
//             color: Colors.amber,
//             onPressed: status ? () {} : null,
//             child: Text('Check this Button!'),
//           ),
//           CupertinoButton(
//               color: Colors.amber,
//               onPressed: () {
//                 setState(() {
//                   status = !status;
//                 });
//               },
//               child: Text(' Disable / Enable'))
//         ],
//       )),
//     );
//   }
// }
