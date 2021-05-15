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

class SignInGoogle extends StatefulWidget {
  static const routeName = '\SignInScreen';
  bool isSignedIn = false;
  setIsSignedIn(bool val) {
    isSignedIn = val;
  }

  @override
  _SignInGoogleState createState() => _SignInGoogleState();
}

class _SignInGoogleState extends State<SignInGoogle> {
  bool isSignedInPrivate = SignInGoogle().isSignedIn;

  saveUIDToDevice(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
  }

  saveTokenToDevice(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  saveIsSignedInStatus(bool signedInStatus) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('signedInStatus', signedInStatus);
  }

  @override
  Widget build(BuildContext context) {
    var key = new GlobalKey<ScaffoldState>();

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // final runStatsProvider = Provider.of<RunDataProvider>(context);
    // final workoutStatsProvider = Provider.of<WorkoutDataProvider>(context);
    // final cycleStatsProvider = Provider.of<CycleDataProvider>(context);
    // final groupStatsProvider = Provider.of<GroupDataProvider>(context);

    //
    //
    _signIn() async {
      print("y");
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      print("x");
      if (googleSignInAccount != null) {
        if (googleSignInAccount.email.endsWith('@iitgn.ac.in')) // iitgn
        {
          GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;
          AuthCredential credential = GoogleAuthProvider.getCredential(
              idToken: googleSignInAuthentication.idToken,
              accessToken: googleSignInAuthentication.accessToken);

          AuthResult result = await _auth.signInWithCredential(credential);
          FirebaseUser user = await _auth.currentUser();
          print(user.uid);

          /// TODO - Collect user info and store on Db

          // add methods to add it to shared pref
          await saveUIDToDevice(user.uid);
          // runStatsProvider.setUid(user.uid);
          // workoutStatsProvider.setUid(user.uid);
          // cycleStatsProvider.setUid(user.uid);
          final idTOKEN = await user.getIdToken();
          String token = idTOKEN.token;
          //print("token is " + token);
          await saveTokenToDevice(token);
          await saveIsSignedInStatus(true);
          // runStatsProvider.setToken(token);
          // workoutStatsProvider.setToken(token);
          // cycleStatsProvider.setToken(token);
          // SignInGoogle().setIsSignedIn(true);
          SignInGoogle().isSignedIn = true;
          isSignedInPrivate = true;
          print("Aabra");
          print(SignInGoogle().isSignedIn);
          print("Dabra");
          // print(googleSignInAccount.);
          print("Sign In Successful");
          Navigator.pushReplacementNamed(context, HomeScreen.routeName,
              result: true); // return true
          //
        } else if (!googleSignInAccount.email
            .endsWith("@iitgn.ac.in")) // non iitgn
        {
          googleSignIn.signOut();
          SignInGoogle().setIsSignedIn(false);

          return false;
        }
      } else {
        googleSignIn.signOut();
        SignInGoogle().setIsSignedIn(false);
        isSignedInPrivate = false;
        return false;
      }
    }

    // void signOut() async {
    //   googleSignIn.disconnect();
    //   _auth.signOut();
    //   SignInGoogle().setIsSignedIn(false);
    //   isSignedInPrivate = false;
    //   SystemNavigator.pop();
    // }

    void _showSnackBar() {
      final snackBar =
          SnackBar(content: Text("Invalid Email Id - Enter IITGN Email ID"));
      key.currentState.showSnackBar(snackBar);
    }

    return Scaffold(
      key: key,
      body: Stack(children: [
        Image.asset(
          'assets/iitgnCamp.jpg',
          height: MediaQuery.of(context).size.height / 1.8,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 25),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFDDDDDD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          MediaQuery.of(context).size.height / 20),
                      topRight: Radius.circular(
                          MediaQuery.of(context).size.height / 20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 10,
                        width: MediaQuery.of(context).size.width / 5,
                        child: Image.asset(
                          "assets/iitgnlogo-emblem.png",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Text(
                          "FIITGN",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width / 7,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 2, 8),
                        child: Text(
                          "THE COMPLETE FITNESS APP",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 18,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      SignInButtonBuilder(
                        text: 'Login with IITGN ID',
                        icon: Icons.email,
                        onPressed: () async {
                          bool outCome = await _signIn();

                          if (outCome == false) {
                            _showSnackBar();
                          }
                        },
                        backgroundColor: Color(0xFF3F7B70),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
