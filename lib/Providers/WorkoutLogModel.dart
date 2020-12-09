import 'package:flutter/foundation.dart';

class WorkoutLogModel {
  // final String uid;
  // final DateTime date;
  final String exerciseName;
  final int setNumber;
  final int numOfReps;

  WorkoutLogModel({
    // @required this.uid,
    // @required this.date,
    @required this.exerciseName,
    @required this.numOfReps,
    @required this.setNumber,
  });
}
