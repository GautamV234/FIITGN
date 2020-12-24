import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'GAuth.dart';
import 'HomeScreen.dart';

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
      final prefs = await SharedPreferences.getInstance();
      final signedInStatus = prefs.getBool('signedInStatus');
      if (signedInStatus == null || signedInStatus == false) {
        Navigator.of(context).pushReplacementNamed(SignInGoogle.routeName);
      } else if (signedInStatus == true) {
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
            Text('FIITGN'),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
