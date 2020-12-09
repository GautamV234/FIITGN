import 'package:flutter/foundation.dart';

class ExerciseModel {
  String exerciseName;
  String assetImageUrl = "";

  ExerciseModel({
    @required this.exerciseName,
    this.assetImageUrl,
  });
}
