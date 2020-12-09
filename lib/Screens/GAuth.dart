import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/RunDataProvider.dart';
import '../Providers/WorkoutDataProvider.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'HomeScreen.dart';

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

  @override
  Widget build(BuildContext context) {
    var key = new GlobalKey<ScaffoldState>();

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final runStatsProvider = Provider.of<RunDataProvider>(context);
    final workoutStatsProvider = Provider.of<WorkoutDataProvider>(context);
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
          runStatsProvider.setUid(user.uid);
          workoutStatsProvider.setUid(user.uid);
          final idTOKEN = await user.getIdToken();
          String token = idTOKEN.token;
          //print("token is " + token);
          runStatsProvider.setToken(token);
          workoutStatsProvider.setToken(token);

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/fitGif.gif"),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text("Welcome to FIITGN.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.white)),
              ),
              SizedBox(height: 100),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                // height: MediaQuery.of(context).size.height*0.07,
                width: MediaQuery.of(context).size.height * 0.7,
                child: FlatButton(
                  onPressed: () async {
                    bool outCome = await _signIn();

                    if (outCome == false) {
                      _showSnackBar();
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(40.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Text(
                        "Login with IITGN ID(Google)",
                        style: TextStyle(
                          color: Colors.white.withAlpha(230),
                        ),
                      ),
                    ),
                  ),
                  color: Color.fromRGBO(228, 110, 96, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
