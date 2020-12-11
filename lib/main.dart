import 'Screens/SelectWorkoutPlanScreen.dart';
import 'package:flutter/material.dart';
import 'Screens/CardioScreen.dart';
import 'Screens/WalkingScreen.dart';
import 'Screens/MapsScreen.dart';
import 'Screens/ShowRunResults.dart';
import 'Screens/YourRunsStatsScreen.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/PolylineShow.dart';
import 'Screens/YourRunsPolyLines.dart';
import 'Screens/UserDetailsScreen.dart';
import 'Providers/storeReturnProvider.dart';
import './Providers/RunDataProvider.dart';
import 'package:provider/provider.dart';
import './Providers/WorkoutDataProvider.dart';
import './Screens/GAuth.dart';
import './Screens/workoutScreen.dart';
import './Screens/workoutLoggingScreen.dart';
import './Screens/WorkoutStatsScreen.dart';
import './Screens/WorkoutDetailsScreen.dart';
import './Screens/NoWorkoutPlanSelectedScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(SignInGoogle().isSignedIn);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: RunDataProvider(),
        ),
        ChangeNotifierProvider.value(
          value: StoreReturnProvider(),
        ),
        ChangeNotifierProvider.value(
          value: WorkoutDataProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'FIITGN',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 0, 100, 1),
          accentColor: Colors.amber,
          //fontFamily: 'Poppins'),
        ),
        // home: StoreReturnProvider().class_userInput_isSet
        // ? SignInFIITGN()
        //     : DetailsScreen(),

        home: SignInGoogle().isSignedIn == true ? HomeScreen() : SignInGoogle(),

        routes: {
          CardioScreen.routeName: (ctx) => CardioScreen(),
          StepCounterScreen.routeName: (ctx) => StepCounterScreen(),
          MapScreen.routeName: (_) => MapScreen(),
          ShowResultsScreen.routeName: (_) => ShowResultsScreen(),
          YourRuns.routeName: (_) => YourRuns(),
          HomeScreen.routeName: (_) => HomeScreen(),
          PolyLineScreen.routeName: (_) => PolyLineScreen(),
          YourRunPolyLineScreen.routeName: (_) => YourRunPolyLineScreen(),
          DetailsScreen.routeName: (_) => DetailsScreen(),
          SignInGoogle.routeName: (_) => SignInGoogle(),
          WorkoutHomeScreen.routeName: (_) => WorkoutHomeScreen(),
          CustomPlansScreen.routeName: (_) => CustomPlansScreen(),
          WorkoutLoggingScreen.routeName: (_) => WorkoutLoggingScreen(),
          WorkoutStatScreen.routeName: (_) => WorkoutStatScreen(),
          WorkoutDetailScreen.routeName: (_) => WorkoutDetailScreen(),
          NoWorkoutPlanSelectedScreen.routeName: (_) =>
              NoWorkoutPlanSelectedScreen()
          //
        },
      ),
    );
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     // return FutureBuilder<FirebaseUser>(
//     //   future: FirebaseAuth.instance.currentUser(),
//     //   builder: (context, snapshot) {
//     //     // if (snapshot.hasData) {
//     //     FirebaseUser user = snapshot.data;
//     //     // return HomeScreen();
//     //     // } else {
//     //     return HomeScreen();
//     //     // }
//     //   },
//     // );
//     return isSignedIn ? HomeScreen() :  ;
//   }
// }
