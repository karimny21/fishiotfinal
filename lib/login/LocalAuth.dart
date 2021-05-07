import 'package:fishiotfinal/screen/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth extends StatefulWidget {
  @override
  _LocalAuthState createState() => _LocalAuthState();
}

class _LocalAuthState extends State<LocalAuth> {
  bool isAuth = false;
  @override
  Widget build(BuildContext context) {
    return isAuth
        ? HomePage()
        : Scaffold(
            backgroundColor: Colors.black,
            body: Center(
                child: InkWell(
              onTap: () {
                _checkBiometric();
              },
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 5.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.fingerprint,
                      color: Colors.amberAccent,
                      size: 30,
                    ),
                    Text(
                      "   Login with Fingerprint",
                      style: TextStyle(
                        fontFamily: 'circe',
                        fontSize: 28,
                        color: Colors.cyanAccent[400],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        shadows: [
                          Shadow(
                            color: Colors.grey[800],
                            offset: Offset(3, 3),
                            blurRadius: 6,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
          );
  }

  void _checkBiometric() async {
    // check for biometric availability
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("error biome trics $e");
    }

    print("biometric is available: $canCheckBiometrics");

    // enumerate biometric technologies
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("error enumerate biometrics $e");
    }

    print("following biometrics are available");
    if (availableBiometrics.isNotEmpty) {
      availableBiometrics.forEach((ab) {
        print("\ttech: $ab");
      });
    } else {
      print("no biometrics are available");
    }

    // authenticate with biometrics
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Touch Your Finger on The Sensor to Login',
          useErrorDialogs: true,
          stickyAuth: false,
          androidAuthStrings:
              AndroidAuthMessages(signInTitle: "Login to Fish Application"));
    } catch (e) {
      print("error using biometric auth: $e");
    }
    setState(() {
      isAuth = authenticated ? true : false;
    });

    print("authenticated: $authenticated");
  }
}
