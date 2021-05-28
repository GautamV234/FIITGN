// This Screen will have the list of all exercises out of which
// the user will chosose exercises for his workout

// import 'package:fiitgn_workouts_1/models/Exercise_db_model.dart';
// import 'package:fiitgn_workouts_1/models/WorkoutModel.dart';
// import 'package:fiitgn_workouts_1/models/Workouts_providers.dart';
import 'package:Fiitgn1/Screens/HomeScreen.dart';

import '../models/Workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Exercise_db_model.dart';

class Create_Workout2 extends StatefulWidget {
  static const routeName = '\CreateWorkout2';

  @override
  _Create_Workout2State createState() => _Create_Workout2State();
}

class _Create_Workout2State extends State<Create_Workout2> {
  final List<ExerciseDbModel> exercisesSelectedForWorkout = [];
  final List<Color> colorList = [];
  @override
  Widget build(BuildContext context) {
    final workoutDataProvider = Provider.of<Workouts_Provider>(context);
    final exerciseDataProvider =
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context);
    final List<ExerciseDbModel> allExerciseList =
        exerciseDataProvider.listExercises;
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    final String workoutName = routeArgs['workoutName'];
    final String access = routeArgs['access'];
    final String description = routeArgs['desription'];
    allExerciseList.forEach(
      (element) {
        colorList.add(Colors.red);
      },
    );
    print(workoutName + " " + access);
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Exercises'),
        actions: [
          InkWell(
            child: Icon(Icons.save),
            onTap: () {
              List<String> listOfExercisesId = [];
              exercisesSelectedForWorkout.forEach(
                (element) {
                  listOfExercisesId.add(element.exerciseId);
                },
              );
              String creatorId = workoutDataProvider.userId;
              String creator_name = workoutDataProvider.user_name;
              List<String> listOfFollowersId = [creatorId];
              workoutDataProvider.createWorkoutAndAddToDB(
                creatorId,
                creator_name,
                workoutName,
                description,
                access,
                listOfExercisesId,
                listOfFollowersId,
              );
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: allExerciseList.length,
        itemBuilder: (ctx, i) {
          return InkWell(
            onTap: () {
              if (!exercisesSelectedForWorkout.contains(allExerciseList[i])) {
                Color color = Colors.green;
                exercisesSelectedForWorkout.add(allExerciseList[i]);
                print("exercise " + allExerciseList[i].exerciseName + " added");
                setState(() {
                  print('colorChange!');
                  colorList[i] = color;
                  print(colorList[i].toString());
                });
              } else {
                Color color = Colors.red;
                exercisesSelectedForWorkout.remove(allExerciseList[i]);
                print(
                    "exercise " + allExerciseList[i].exerciseName + " removed");
                setState(() {
                  colorList[i] = color;
                });
              }
            },
            child: Card(
              color: colorList[i],
              child: Column(
                children: [
                  Text(
                    allExerciseList[i].exerciseName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    allExerciseList[i].description,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
