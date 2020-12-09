import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
// import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:path_provider/path_provider.dart';
// import './userDetailsScreen.dart';
import 'HomeScreen.dart';

// final GoogleSignIn gSignIn = GoogleSignIn();
// FirebaseUser firebaseUser;
// final FirebaseAuth firebaseauth = FirebaseAuth.instance;
// // final FirebaseAuth _auth = FirebaseAuth.instance;

// logout() async {
//   gSignIn.signOut();
//   FirebaseAuth.instance.signOut();
// }

final GoogleSignIn googleSignInObject = GoogleSignIn();
FirebaseUser fireBaseUser;
final FirebaseAuth fireBaseAuth = FirebaseAuth.instance;

class SignInFIITGN extends StatefulWidget {
  @override
  _SignInFIITGNState createState() => _SignInFIITGNState();
}

final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

logoutUser() async {
  googleSignInObject.signOut();
  FirebaseAuth.instance.signOut();
  // SharedPreferences log = await SharedPreferences.getInstance();
  // log.setBool('welcome', false);
  SystemNavigator.pop();
}

class _SignInFIITGNState extends State<SignInFIITGN> {
  bool isSignedIn = false;

  // Future<bool> checkWelcome() async {
  //   print("checkWelcome is being run");
  //   SharedPreferences log = await SharedPreferences.getInstance();
  //   bool x = log.getBool('welcome');
  //   if (x == null) // that means x is a new user
  //   {
  //     log.setBool('welcome', true);
  //     return true;
  //   } else {
  //     return false; // false would mean the user has signed in before
  //   }
  // }

  Future checkSignIn() async {
    print("checkkSignIn has been run");
    fireBaseUser = await _fireBaseAuth.currentUser();
    return fireBaseUser;
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   checkWelcome().then((val) {
  //     if (val == true) {
  //       // push the main Screen seedha in our case userDetailsScreen if val is true i.e new User.
  //       // Navigator.pushReplacementNamed(context, DetailsScreen.routeName);
  //       print("check Welcome is true ");
  //     }
  //   });

  //   checkSignIn().then((value) async {
  //     try {
  //       print("Sign in silently");
  //       await googleSignInObject.signInSilently().then(
  //         (googleSignInAccountObject) {
  //           print('Silent Sign in successful');
  //           controlSignIn(googleSignInAccountObject);
  //         },
  //       ).catchError((gError) {
  //         print("Error message :" + gError);
  //       });
  //     } catch (e) {
  //       print('Error:' + e);
  //     }
  //     try {
  //       print("on current user changed");
  //       googleSignInObject.onCurrentUserChanged.listen((googleSignInAccount) {
  //         print(googleSignInAccount);
  //         controlSignIn(googleSignInAccount);
  //       }, onError: (getError) {
  //         print("Error Message" + getError);
  //       });
  //     } catch (e) {
  //       print("Error:" + e);
  //     }
  //   });
  // }

  // controlSignIn(GoogleSignInAccount signInAccount) async {
  //   print("controlSignIn has been run");
  //   print('Checking for correct account');
  //   print(signInAccount);
  //   print("Blah");
  //   if (signInAccount != null) {
  //     print('actually signed in');
  //     if (!googleSignInObject.currentUser.email.endsWith('@iitgn.ac.in')) {
  //       await logoutUser();
  //       key.currentState.hideCurrentSnackBar();
  //       key.currentState.showSnackBar(
  //           SnackBar(content: Text("Please sign in with your IITGN account!")));
  //     } else {
  //       authorize(false); // this means not guest
  //       setState(() {
  //         isSignedIn = true;
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       isSignedIn = false;
  //     });
  //   }
  // }

  // void authorize(bool isGuest) async {
  //   print("authorize has been run");
  //   if (isGuest == false) {
  //     print("Awaiting gsignin sign in");
  //     await googleSignInObject.signIn();
  //     print(" gsignin signed in");

  //     try {
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleSignInObject.currentUser.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.getCredential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       fireBaseUser =
  //           (await fireBaseAuth.signInWithCredential(credential)).user;
  //     } catch (e) {
  //       print(e);
  //     }
  //     Navigator.pop(key.currentContext);
  //     Navigator.pushNamed(context, HomeScreen.routeName);
  //   }
  // }

  var key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        key: key,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/fitGif.gif"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Text("FIITGN",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                ),
                SizedBox(height: 100),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  // height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: FlatButton(
                    onPressed: () => null,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 8),
                  child: Text(
                    "or",
                    style: TextStyle(
                      color: Colors.grey.withAlpha(230),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
