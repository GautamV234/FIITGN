// import 'package:Fiitgn1/Screens/homeScreen.dart';
// import 'package:flutter/material.dart';
// import 'Screens/goForARunScreen.dart';
// import './Screens/walkingScreen.dart';
// import './Screens/mapsScreen.dart';
// import './Screens/showResults.dart';
// import 'package:provider/provider.dart';
// import './Providers/RunDataProvider.dart';
// import './Screens/yourRunsScreen.dart';
// import 'Screens/homeScreen.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (ctx) => RunDataProvider(),
//       child: MaterialApp(
//         title: 'FIITGN',
//         theme: ThemeData(
//           primaryColor: Color.fromRGBO(0, 0, 100, 1),
//           accentColor: Colors.amber,
//           //fontFamily: 'Poppins'),
//         ),
//         home: HomeScreen(),
//         routes: {
//           CardioScreen.routeName: (ctx) => CardioScreen(),
//           StepCounterScreen.routeName: (ctx) => StepCounterScreen(),
//           MapScreen.routeName: (_) => MapScreen(),
//           ShowResultsScreen.routeName: (_) => ShowResultsScreen(),
//           YourRuns.routeName: (_) => YourRuns(),
//           HomeScreen.routeName: (_) => HomeScreen(),
//         },
//       ),
//     );
//   }
// }
