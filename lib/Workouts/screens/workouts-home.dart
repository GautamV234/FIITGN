import 'package:flutter/material.dart';
import './your-workouts.dart';
import 'create_workout1.dart';
import './explore_workouts.dart';
import '../../Notifications/Notifications.dart';

class Workouts_Home extends StatelessWidget {
  static const routeName = '\Workouts-Home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workouts'),
      ),
      body: ListView(
        children: [
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Your_Workouts.routeName);
              },
              child: Text(
                'Your Workouts',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Explore_Workouts.routeName);
              },
              child: Text(
                'Explore Workouts',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Create_Workout1.routeName);
              },
              child: Text(
                'Create Workouts',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Notifications.routeName);
              },
              child: Text(
                'Notifications',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
