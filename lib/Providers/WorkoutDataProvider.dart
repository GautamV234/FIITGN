import 'package:Fiitgn1/Providers/WorkoutDataModel.dart';
import 'package:Fiitgn1/Providers/WorkoutLogModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './PlanModel.dart';
import 'ExerciseModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorkoutDataProvider with ChangeNotifier {
  String _uid;
  String _token;
  String _currentPlan = "";

  static final List<ExerciseModel> _exercises = [
    ExerciseModel(
      exerciseName: "Jump Squats",
      assetImageUrl: "assets/jumpSquats.gif",
    ),
    ExerciseModel(
      exerciseName: "Pushups",
      assetImageUrl: "assets/pushUp.gif",
    ),
    ExerciseModel(
      exerciseName: "Situps",
      assetImageUrl: "assets/Situps.gif",
    ),
    ExerciseModel(
      exerciseName: "Jumping Jacks",
      assetImageUrl: "assets/jumpingJack.gif",
    ),
    ExerciseModel(
      exerciseName: "Chinups",
      assetImageUrl: "assets/chinUp.gif",
    ),
    ExerciseModel(
      exerciseName: "Declined bench Knee Twist",
    ),
    ExerciseModel(
      exerciseName: "Deadlift",
      assetImageUrl: "assets/Deadlift.gif",
    ),
    ExerciseModel(
      exerciseName: "Machine Lat pull down",
    ),
    ExerciseModel(
      exerciseName: "Mountain Climber",
      assetImageUrl: "assets/MountainClimbers.gif",
    ),
  ];

  final List<PlanModel> _customPlans = [
    PlanModel(
      planName: "Madhu's Plan",
      mondayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Mountain Climber",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Situps",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Jump Squats",
        ),
      ],
      tuesdayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Mountain Climber",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Situps",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Jump Squats",
        ),
      ],
      wednesdayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Mountain Climber",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Situps",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Jump Squats",
        ),
      ],
      thursdayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Jump Squats",
        ),
      ],
      fridayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Mountain Climber",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Deadlift",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Jumping Jacks",
        ),
      ],
      saturdayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Mountain Climber",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Situps",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Jump Squats",
        ),
      ],
      sundayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Mountain Climber",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Situps",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Jump Squats",
        ),
      ],
    ),
    PlanModel(
      planName: "Gautam's Plan",
      mondayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Chinups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Situps",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Jump Squats",
        ),
      ],
      tuesdayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Chinups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Situps",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Jump Squats",
        ),
      ],
      wednesdayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Chinups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Situps",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Jump Squats",
        ),
      ],
      thursdayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Chinups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Situps",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Jump Squats",
        ),
      ],
      fridayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Chinups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Situps",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Mountain Climber",
        ),
      ],
      saturdayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Chinups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Situps",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Jump Squats",
        ),
      ],
      sundayExercises: [
        _exercises.firstWhere(
          (element) => element.exerciseName == "Pushups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Chinups",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Situps",
        ),
        _exercises.firstWhere(
          (element) => element.exerciseName == "Jump Squats",
        ),
      ],
    ),
  ];

  List<WorkoutDataModel> _yourWorkouts = [];

  final List<PlanModel> _myPlans = [];

  List<ExerciseModel> get exercises {
    return [..._exercises];
  }

  void setToken(String token) {
    _token = token;
  }

  void setUid(String uid) {
    _uid = uid;
    // print('uid has been set');
    notifyListeners();
    // print("uid is $_uid");
  }

  String get getUid {
    return _uid;
  }

  List<PlanModel> get customPlans {
    return [..._customPlans];
  }

  List<PlanModel> get myPlans {
    return [..._myPlans];
  }

  List<WorkoutDataModel> get yourWorkouts {
    return _yourWorkouts;
  }

  Future<void> getWorkoutStatsFromDB() async {
    final url =
        'https://authentications-c0299.firebaseio.com/WorkoutData.json?auth=$_token&orderBy="uid"&equalTo="$_uid"';
    try {
      final response = await http.get(url);
      final List<WorkoutDataModel> loadedData = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((statId, statVal) {
        final List<WorkoutLogModel> listOfSetsReps = [];
        final Map mapSetsReps = statVal['listOfSetsReps'];
        mapSetsReps.forEach((key, value) {
          listOfSetsReps.add(new WorkoutLogModel(
              exerciseName: value['exerciseName'],
              numOfReps: value['numOfReps'],
              setNumber: value['setNumber']));
        });
        loadedData.add(
          new WorkoutDataModel(
            databaseId: statId,
            uid: statVal['uid'],
            date: statVal['date'],
            listOfSetsReps: listOfSetsReps,
            planName: statVal['planName'],
          ),
        );

        _yourWorkouts = loadedData;
        notifyListeners();
      });
      print("Loaded List for Workout Stats is ready");
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveToYourWorkouts(WorkoutDataModel data) async {
    final url =
        'https://authentications-c0299.firebaseio.com/WorkoutData.json?auth=$_token';
    final listOfSetsReps = [];
    data.listOfSetsReps.forEach((element) {
      listOfSetsReps.add(
        {
          'exerciseName': element.exerciseName,
          'setNumber': element.setNumber,
          'numOfReps': element.numOfReps,
        },
      );
    });
    return http
        .post(
      url,
      body: json.encode(
        {
          'uid': data.uid,
          'date': data.date,
          'planName': data.planName,
          'listOfSetsReps': listOfSetsReps,
        },
      ),
    )
        .then(
      (response) {
        var databaseId = json.decode(response.body)['name'];
        _yourWorkouts.add(
          new WorkoutDataModel(
            databaseId: databaseId,
            uid: data.uid,
            date: data.date,
            listOfSetsReps: data.listOfSetsReps,
            planName: data.planName,
          ),
        );
        notifyListeners();
      },
    );
    // _yourWorkouts.add(data);
  }

  Future<String> get currentPlan async {
    final _currentPlanFromDevice = await SharedPreferences.getInstance();
    final planNameSP = _currentPlanFromDevice.getString('planName');
    if (planNameSP == null) {
      return "";
    }
    return planNameSP;
    // return _currentPlan;
  }

  Future<void> makeCurrentPlan(String planName) async {
    final _currentPlanFromDevice = await SharedPreferences.getInstance();
    await _currentPlanFromDevice.setString('planName', planName);
    _currentPlan = planName;
    print("New plan set" + planName);
    notifyListeners();
  }

  void tempMakeCurrentPlan(String planName) {
    _currentPlan = planName;
    notifyListeners();
  }
}
