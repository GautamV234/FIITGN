import 'package:flutter/foundation.dart';
import './ExerciseModel.dart';

class PlanModel {
  final String planName;
  // final String routeName;
  final List<ExerciseModel> mondayExercises;
  final List<ExerciseModel> tuesdayExercises;
  final List<ExerciseModel> wednesdayExercises;
  final List<ExerciseModel> thursdayExercises;
  final List<ExerciseModel> fridayExercises;
  final List<ExerciseModel> saturdayExercises;

  final List<ExerciseModel> sundayExercises;

  PlanModel({
    @required this.planName,
    // @required this.routeName,
    @required this.mondayExercises,
    @required this.tuesdayExercises,
    @required this.wednesdayExercises,
    @required this.thursdayExercises,
    @required this.fridayExercises,
    @required this.saturdayExercises,
    @required this.sundayExercises,
  });
}
