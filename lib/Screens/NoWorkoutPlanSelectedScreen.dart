import 'package:flutter/material.dart';

class NoWorkoutPlanSelectedScreen extends StatelessWidget {
  static const routeName = '\NoWorkoutPlanSelectedScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No Plan Selected'),
      ),
      body: Center(
        child: Text('No Plan Selected'),
      ),
    );
  }
}
