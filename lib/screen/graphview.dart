import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_web/flutter_native_web.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class GraphMonitor extends StatefulWidget {
  @override
  _GraphMonitorState createState() => _GraphMonitorState();
}

class _GraphMonitorState extends State<GraphMonitor> {
  // Field
  String urlPh =
          'https://thingspeak.com/channels/1039081/charts/1?bgcolor=%23FFFFFF&color=%23000000&dynamic=true&max=16&min=0&results=60&title=pH&type=line',
      urlTurbidity =
          'https://thingspeak.com/channels/1039081/charts/2?bgcolor=%23FFFFFF&color=%230300AC&dynamic=true&max=5&min=0&results=60&title=Turbidity&type=line',
      urlTemperature =
          'https://thingspeak.com/channels/1039081/charts/3?bgcolor=%23FFFFFF&color=%23AC0000&dynamic=true&max=30&min=0&results=60&title=Temperature&type=line';

  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  WebController webController;

  void onWebPh(webController) {
    this.webController = webController;
    this.webController.loadUrl(urlPh);
    this
        .webController
        .onPageFinished
        .listen((url) => print("Finished loading $url"));
  }

  void onWebTurbidity(webController) {
    this.webController = webController;
    this.webController.loadUrl(urlTurbidity);
    this.webController.onPageStarted.listen((url) => print("Loading $url"));
    this
        .webController
        .onPageFinished
        .listen((url) => print("Finished loading $url"));
  }

  void onWebTemperature(webController) {
    this.webController = webController;
    this.webController.loadUrl(urlTemperature);
    this.webController.onPageStarted.listen((url) => print("Loading $url"));
    this
        .webController
        .onPageFinished
        .listen((url) => print("Finished loading $url"));
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeWeb flutterWebPh = new FlutterNativeWeb(
      onWebCreated: onWebPh,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
          () => TapGestureRecognizer(),
        ),
      ].toSet(),
    );

    FlutterNativeWeb flutterWebTurbidity = new FlutterNativeWeb(
      onWebCreated: onWebTurbidity,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
          () => TapGestureRecognizer(),
        ),
      ].toSet(),
    );

    FlutterNativeWeb flutterWebTemperature = new FlutterNativeWeb(
      onWebCreated: onWebTemperature,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
          () => TapGestureRecognizer(),
        ),
      ].toSet(),
    );

    return Scaffold(
      body: ListView(
        children: <Widget>[
          // Container(
          // child: Text('Test'),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: flutterWebTurbidity,
                  height: 300.0,
                  width: 500.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: flutterWebPh,
                  height: 300.0,
                  width: 500.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: flutterWebTemperature,
                  height: 300.0,
                  width: 500.0,
                ),
              ),
              SizedBox(height: 30.0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'This Graph From  ',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                      text: 'ThingSpeak.com',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ],
      ),
    );
  }
}
