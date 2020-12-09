import 'package:flutter/material.dart';
import 'SelectWorkoutPlanScreen.dart';
import '../Widgets/HomeScreenItem.dart';
import '../Screens/workoutLoggingScreen.dart';

class WorkoutHomeScreen extends StatelessWidget {
  static const routeName = '\workoutScreen';
  final List workoutScreenList = [
    {
      'title': 'Start Workout',
      'url': 'assets/WorkoutTabs.jpg',
      'routeName': WorkoutLoggingScreen.routeName,
    },
    {
      'title': 'Custom Plans',
      'url': 'assets/WorkoutTabs.jpg',
      'routeName': CustomPlansScreen.routeName,
    },
    {
      'title': 'Create Plan',
      'url': 'assets/WorkoutTabs.jpg',
      'routeName': " ",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Workout'),
        elevation: 12,
      ),
      body: ListView.builder(
        itemCount: workoutScreenList.length,
        itemBuilder: (ctx, i) => HomeScreenItem(
          routeName: workoutScreenList[i]['routeName'],
          title: workoutScreenList[i]['title'],
          url: workoutScreenList[i]['url'],
        ),
      ),
    );
  }
}
