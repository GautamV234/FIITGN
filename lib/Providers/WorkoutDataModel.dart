import 'package:flutter/foundation.dart';
import 'WorkoutLogModel.dart';

class WorkoutDataModel {
  String databaseId = "";
  final String uid;
  final String date;
  final List<WorkoutLogModel> listOfSetsReps;
  final String planName;

  WorkoutDataModel({
    @required this.databaseId,
    @required this.uid,
    @required this.date,
    @required this.listOfSetsReps,
    @required this.planName,
  });
}
