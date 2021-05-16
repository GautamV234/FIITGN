import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'HomeScreen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SignInGoogle extends StatefulWidget {
  static const routeName = '\SignInScreen';
  bool isSignedIn = false;
  setIsSignedIn(bool val) {
    isSignedIn = val;
  }

  @override
  _SignInGoogleState createState() => _SignInGoogleState();
}

logoutUser() async {
  final GoogleSignIn googleSignInObject = GoogleSignIn();
  FirebaseUser fireBaseUser;
  final FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
  print('Logging Out');
  await googleSignInObject.signOut();
  await FirebaseAuth.instance.signOut();
}

class SignInClass {
  BuildContext context;
  SignInClass({this.context});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =
      GoogleSignIn(hostedDomain: 'iitgn.ac.in', scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/calendar',
  ]);

  signIn() async {
    // print("y");
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    // print("x");
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = await _auth.signInWithCredential(credential);
    FirebaseUser user = await _auth.currentUser();
    print(user.uid);
    final idTOKEN = await user.getIdToken();
    String uid = user.uid;
    String token = idTOKEN.token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
    prefs.setString('token', token);
    SignInGoogle().isSignedIn = true;
    // isSignedInPrivate = true;
    print(SignInGoogle().isSignedIn);
    print("Sign In Successful");
    Navigator.pushReplacementNamed(context, HomeScreen.routeName,
        result: true); // return true
  }

  logoutUser() async {
    print('Logging Out');
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}

class _SignInGoogleState extends State<SignInGoogle> {
  bool isSignedInPrivate = SignInGoogle().isSignedIn;
  final GoogleSignIn googleSignInObject = GoogleSignIn();
  FirebaseUser fireBaseUser;
  final FirebaseAuth fireBaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var key = new GlobalKey<ScaffoldState>();

    void _showSnackBar() {
      final snackBar =
          SnackBar(content: Text("Invalid Email Id - Enter IITGN Email ID"));
      key.currentState.showSnackBar(snackBar);
    }

    /// UI post here

    return Scaffold(
      key: key,
      body: Stack(
        children: [
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
                                fontSize:
                                    MediaQuery.of(context).size.width / 18,
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
                            bool outCome =
                                await SignInClass(context: context).signIn();

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
        ],
      ),
    );
  }
}
