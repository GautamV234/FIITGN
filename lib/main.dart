// import 'package:Fiitgn1/Providers/DataProvider.dart';
import 'package:Fiitgn1/Workouts/screens/wishlist.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Calendar-Schedule/calendar_try_screen.dart';
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
import 'Screens/StatsScreen.dart';
import './Screens/CycleScreen.dart';
import './Screens/ShowCycleResults.dart';
import './Screens/yourCycleStatsScreen.dart';
import './Providers/CycleDataProvider.dart';
import './Screens/SplashScreen.dart';
// import 'lib/Calendar-Schedule/schedueCalendar.dart';

///////// WORKOUTS SECTION
import 'Workouts/screens/workouts-home.dart';
import 'Workouts/screens/your-workouts.dart';
import 'Workouts/screens/ongoing_workouts.dart';
import 'Workouts/screens/wishlist.dart';
import 'Workouts/models/Workout_provider.dart';
import 'Workouts/screens/create_workout1.dart';
import 'Workouts/screens/create_workouts2.dart';
import './Providers/DataProvider.dart';
import 'Workouts/models/Admin_db_model.dart';
import 'Workouts/models/Exercise_db_model.dart';
import 'Workouts/screens/explore_workouts.dart';
import 'Workouts/screens/exercises_in_workout.dart';
import 'Workouts/screens/created_by_user.dart';
import 'Notifications/Notifications.dart';
////////Allocation
import 'Allocation/screens/sports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Method needed to initialize firebase application.
  await Firebase.initializeApp();
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
        ChangeNotifierProvider.value(
          value: CycleDataProvider(),
        ),
        //// WORKOUTS
        ChangeNotifierProvider.value(
          value: Workouts_Provider(),
        ),
        ChangeNotifierProvider.value(
          value: Data_Provider(),
        ),
        ChangeNotifierProvider.value(
          value: GetAdminDataFromGoogleSheetProvider(),
        ),
        ChangeNotifierProvider.value(
          value: GetExerciseDataFromGoogleSheetProvider(),
        )
      ],
      child: MaterialApp(
        title: 'FIITGN',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFFF05454),
          accentColor: Color(0xFF414141),
          backgroundColor: Color(0xFFF0F0F0),
          //fontFamily: 'Poppins'),
        ),
        // home: StoreReturnProvider().class_userInput_isSet
        // ? SignInFIITGN()
        // : DetailsScreen(),

        home: SplashScreen(),

        routes: {
          CardioScreen.routeName: (ctx) => CardioScreen(),
          StepCounterScreen.routeName: (ctx) => StepCounterScreen(),
          MapScreen.routeName: (_) => MapScreen(),
          ShowResultsScreen.routeName: (_) => ShowResultsScreen(),
          YourRuns.routeName: (_) => YourRuns(),
          HomeScreen.routeName: (_) => HomeScreen(),
          PolyLineScreen.routeName: (_) => PolyLineScreen(),
          YourRunPolyLineScreen.routeName: (_) => YourRunPolyLineScreen(),
          // DetailsScreen.routeName: (_) => DetailsScreen(),
          SignInGoogle.routeName: (_) => SignInGoogle(),
          WorkoutHomeScreen.routeName: (_) => WorkoutHomeScreen(),
          CustomPlansScreen.routeName: (_) => CustomPlansScreen(),
          WorkoutLoggingScreen.routeName: (_) => WorkoutLoggingScreen(),
          WorkoutStatScreen.routeName: (_) => WorkoutStatScreen(),
          WorkoutDetailScreen.routeName: (_) => WorkoutDetailScreen(),
          NoWorkoutPlanSelectedScreen.routeName: (_) =>
              NoWorkoutPlanSelectedScreen(),
          StatsScreen.routeName: (_) => StatsScreen(),
          CycleScreen.routeName: (_) => CycleScreen(),
          ShowCycleResultsScreen.routeName: (_) => ShowCycleResultsScreen(),
          YourCycleStats.routeName: (_) => YourCycleStats(),
          CalendarScreen.routeName: (_) => CalendarScreen(),
          ///// WOKROUTS SECTION
          Workouts_Home.routeName: (_) => Workouts_Home(),
          Your_Workouts.routeName: (_) => Your_Workouts(),
          Ongoing_Workouts.routeName: (_) => Ongoing_Workouts(),
          Wishlist.routeName: (_) => Wishlist(),
          Create_Workout1.routeName: (_) => Create_Workout1(),
          Create_Workout2.routeName: (_) => Create_Workout2(),
          Explore_Workouts.routeName: (_) => Explore_Workouts(),
          Exercises_in_Workout.routeName: (_) => Exercises_in_Workout(),
          Created_by_user.routeName: (_) => Created_by_user(),
          Notifications.routeName: (_) => Notifications(),
          
          ///// Allocation Section
          Sports.routeName: (_) => Sports(),
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
