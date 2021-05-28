import 'package:flutter/foundation.dart';
import 'Workouts_Log_Model.dart';
// import 'WorkoutLogModel.dart';

class WorkoutDataModel {
  String databaseId = "";
  final String uid;
  final String user_name;
  final String date;
  final List<Workout_Log_Model> listOfSetsReps;
  final String workoutName;

  WorkoutDataModel({
    @required this.databaseId,
    @required this.uid,
    @required this.user_name,
    @required this.workoutName,
    @required this.date,
    @required this.listOfSetsReps,
  });
}
