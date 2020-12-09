// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import './authentications.dart';
// import 'Screens/homeScreen.dart';
// import 'Providers/RunDataProvider.dart';
// import 'package:provider/provider.dart';
// // import 'package:form_field_validator/form_field_validator.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   // String email;
//   // String password;
//   // GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   // void login() {
//   //   if (formkey.currentState.validate()) {
//   //     formkey.currentState.save();
//   //     googleSignIn().then((value) {
//   //       if (value != null) {
//   //         uid = value; // value is uid  (check google sign in code for details)
//   //         if (uid == "Not IITGN") {
//   //          return AlertDialog(
//   //             title: Text("It"),
//   //           );
//   //         } else {
//   //           Navigator.pushReplacement(
//   //             context,
//   //             MaterialPageRoute(
//   //               builder: (context) {
//   //                 return HomeScreen();
//   //               },
//   //             ),
//   //           );
//   //         }
//   //       }
//   //     });
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final runDataProvider = Provider.of<RunDataProvider>(context);

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Text(
//                 'Welcome to FIITGN ',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                 ),
//               ),
//               MaterialButton(
//                 padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
//                 // onPressed: () => googleSignIn().whenComplete(() async {
//                 //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
//                 //   // print("Blah Blah");
//                 //   // print(user.uid);
//                 //   runDataProvider.setUid(user.uid);
//                 // Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 //     builder: (context) => TasksPage(uid: user.uid)));
//                 // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
//                 // },
//                 onPressed: () => googleSignIn().then(
//                   (value) async {
//                     print("value is $value ");
//                     if (value != 'Not IITGN') {
//                       FirebaseUser user =
//                           await FirebaseAuth.instance.currentUser();
//                       print(user.uid);
//                       runDataProvider.setUid(user.uid);
//                       print("Code reaches here");
//                       Navigator.pushReplacementNamed(
//                           context, HomeScreen.routeName);
//                     } else {
//                       print("Value for else is $value");
//                       signOutUser();
//                     }
//                   },
//                 ),
//                 child: Image(
//                   image: AssetImage('assets/signin.png'),
//                   width: 300.0,
//                 ),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
