import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'GAuth.dart';
import 'HomeScreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/RunDataProvider.dart';
import '../Providers/WorkoutDataProvider.dart';
import '../Providers/CycleDataProvider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'HomeScreen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'GAuth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'HomeScreen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () async {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      bool isUserSignedIn = await googleSignIn.isSignedIn();
      // final prefs = await SharedPreferences.getInstance();
      // final signedInStatus = prefs.getBool('signedInStatus');
      if (isUserSignedIn == null || isUserSignedIn == false) {
        Navigator.of(context).pushReplacementNamed(SignInGoogle.routeName);
      } else if (isUserSignedIn == true) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.width / 5,
              child: Image.asset(
                "assets/iitgnlogo-emblem.png",
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 25.7125,
                  MediaQuery.of(context).size.width / 51.425,
                  MediaQuery.of(context).size.width / 25.7125,
                  0),
              child: Text(
                "FIITGN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 7,
                    color: Colors.black),
              ),
            ),
            TypewriterAnimatedTextKit(
              onTap: () {
                // print("Tap Event");
              },
              text: [
                'loading',
              ],
              textStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 15,
                  color: Colors.grey),
            ),
            // CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
