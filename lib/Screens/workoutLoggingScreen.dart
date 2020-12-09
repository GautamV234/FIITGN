import 'package:Fiitgn1/Providers/ExerciseModel.dart';
import 'package:Fiitgn1/Providers/PlanModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Providers/WorkoutDataProvider.dart';
import 'package:provider/provider.dart';
import '../Providers/WorkoutLogModel.dart';
import '../Providers/WorkoutDataModel.dart';

class WorkoutLoggingScreen extends StatefulWidget {
  static const routeName = '\StartWorkoutScreen';

  @override
  _WorkoutLoggingScreenState createState() => _WorkoutLoggingScreenState();
}

int setCount;
List<WorkoutLogModel> setsAndReps = List<WorkoutLogModel>();
List<WorkoutLogModel> workoutList = List<WorkoutLogModel>();

class _WorkoutLoggingScreenState extends State<WorkoutLoggingScreen> {
  String currentPlanName = "";
  // @override
  // void initState() {
  //   final workoutDataProvider = Provider.of<WorkoutDataProvider>(context);

  //   workoutDataProvider.currentPlan.then((value) {
  //     currentPlanName = value;
  //   });
  //   // TODO: implement initState
  //   super.initState();
  // }

  // Future<void> getCurrentPlan() async {
  //   print("get Current Plan initialized");
  //   final workoutDataProvider =
  //       Provider.of<WorkoutDataProvider>(context, listen: false);
  //   currentPlanName = await workoutDataProvider.currentPlan;
  //   print("Current plan Name set==" + currentPlanName);
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   getCurrentPlan();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // getCurrentPlan();
    final workoutDataProvider = Provider.of<WorkoutDataProvider>(context);
    String currentPlanName = "";
    currentPlanName = workoutDataProvider.currentPlan;
    print("currentPlanName is " + currentPlanName);
    print(currentPlanName == "");
    String uid = workoutDataProvider.getUid;

    PlanModel currentPlan;
    if (currentPlanName == "") {
      print("No Plan Selected Yet");
      //  add stuff corresponding to no plan selected
    } else {
      final List<PlanModel> x = workoutDataProvider.customPlans;
      currentPlan =
          x.firstWhere((element) => element.planName == currentPlanName);
    }

    final DateTime date = DateTime.now();
    final String dateIso = date.toIso8601String();
    final String day = DateFormat.EEEE().format(date);
    List<ExerciseModel> currentExerciseModel;
    if (currentPlanName != "") {
      if (day == 'Monday') {
        currentExerciseModel = currentPlan.mondayExercises;
      } else if (day == 'Tuesday') {
        currentExerciseModel = currentPlan.tuesdayExercises;
      } else if (day == 'Wednesday') {
        currentExerciseModel = currentPlan.wednesdayExercises;
      } else if (day == 'Thursday') {
        currentExerciseModel = currentPlan.thursdayExercises;
      } else if (day == 'Friday') {
        currentExerciseModel = currentPlan.fridayExercises;
      } else if (day == 'Saturday') {
        currentExerciseModel = currentPlan.saturdayExercises;
      } else if (day == 'Sunday') {
        currentExerciseModel = currentPlan.sundayExercises;
      }
    }

    void addNewSet(String exerciseName, int setVal, int repVal) {
      final WorkoutLogModel newData = WorkoutLogModel(
        exerciseName: exerciseName,
        numOfReps: repVal,
        setNumber: setVal,
      );

      setsAndReps.add(newData);
      // testing
      print(newData.setNumber);
      print("Value aded " + setsAndReps[setsAndReps.length - 1].exerciseName);
    }

    void saveData(String uid, String date, List<WorkoutLogModel> exercices,
        String planName) {
      print("save data initiated");
      print("User UID is " + uid);
      WorkoutDataModel data = WorkoutDataModel(
          databaseId: "",
          uid: uid,
          date: date,
          listOfSetsReps: exercices,
          planName: planName);
      setsAndReps = List<WorkoutLogModel>();
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Do you want to save and End?"),
          actions: [
            FloatingActionButton(
              child: Text("Yes"),
              onPressed: () {
                workoutDataProvider.saveToYourWorkouts(data);
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              },
            ),
            FloatingActionButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: currentPlanName == "" ? null : Text(currentPlanName),
        actions: [
          IconButton(
            icon: Icon(Icons.save_sharp),
            onPressed: () =>
                saveData(uid, dateIso, setsAndReps, currentPlanName),
          )
        ],
      ),
      body: currentPlanName == ""
          ? Center(
              child: Text('No Plan Selected'),
            )
          : Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2 + 50,
                    child: ListView.builder(
                      itemCount: currentExerciseModel.length,
                      itemBuilder: (ctx, index) => Container(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: currentExerciseModel[index]
                                          .assetImageUrl ==
                                      null
                                  ? Text('No Image yet')
                                  : Image.asset(
                                      currentExerciseModel[index].assetImageUrl,
                                      height: 300,
                                      width: 300,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  elevation: 10,
                                  child: Text(
                                      currentExerciseModel[index].exerciseName),
                                ),
                                RaisedButton.icon(
                                  icon: Icon(Icons.add),
                                  label: Text('Add Log'),
                                  onPressed: () {
                                    print("i= " + index.toString());
                                    final TextEditingController
                                        repEditingController =
                                        TextEditingController();
                                    final TextEditingController
                                        setEditingController =
                                        TextEditingController();
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text('Add Reps'),
                                        actions: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Add Set Number"),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller:
                                                            setEditingController,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Add rep count"),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller:
                                                            repEditingController,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                FlatButton(
                                                  child: Text("Done"),
                                                  onPressed: () {
                                                    String repVal =
                                                        repEditingController
                                                            .text;
                                                    String setVal =
                                                        setEditingController
                                                            .text;
                                                    print(index.toString() +
                                                        " this is the value of i ");
                                                    String currentExerciseName =
                                                        currentExerciseModel[
                                                                index]
                                                            .exerciseName;
                                                    print(currentExerciseName +
                                                        " is the name");
                                                    // print("same exercise");
                                                    addNewSet(
                                                      currentExerciseName,
                                                      int.parse(setVal),
                                                      int.parse(repVal),
                                                    );

                                                    // print("different exercise");
                                                    Navigator.of(ctx).pop(true);

                                                    setsAndReps.forEach(
                                                      (element) {
                                                        if (element
                                                                .exerciseName ==
                                                            currentExerciseName) {
                                                          workoutList
                                                              .add(element);
                                                          print(workoutList[
                                                              workoutList
                                                                      .length -
                                                                  1]);
                                                          setState(() {});
                                                        }
                                                      },
                                                    );
                                                    // testing
                                                    print(index.toString() +
                                                        " val of i after popping");
                                                    print(setsAndReps.length
                                                            .toString() +
                                                        " len");
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),

                            // setsAndReps.length == 0
                            //     ? Center(
                            //         child: Text("None"),
                            //       )
                            //     : Container(
                            //         height: MediaQuery.of(context).size.height / 10,
                            //         child: chintuMalvsSucks.length == 0
                            //             ? Center(
                            //                 child: Text("None"),
                            //               )
                            //             : ListView.builder(
                            //                 itemCount: chintuMalvsSucks.length,
                            //                 itemBuilder: (ctx, item) {
                            //                   print("i= " +
                            //                       index.toString() +
                            //                       " and  j = " +
                            //                       item.toString());
                            //                   return ListTile(
                            //                     title: Text(
                            //                       "Set " +
                            //                           setsAndReps[item].setNumber.toString(),
                            //                     ),
                            //                     subtitle: Text(
                            //                       "Reps- " +
                            //                           setsAndReps[item].numOfReps.toString(),
                            //                     ),
                            //                   );
                            //                 }),
                            //       ),
                            // add the list of sets and reps
                            // SizedBox(
                            //   height: 20,
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Theme.of(context).accentColor,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Stats",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(0),
                          height: MediaQuery.of(context).size.height / 3 - 50,
                          child: ListView.builder(
                            itemCount: setsAndReps.length,
                            itemBuilder: (ctx, t) {
                              print("abcde");
                              return ListTile(
                                title: Text(setsAndReps[t].exerciseName),
                                subtitle: Column(
                                  children: [
                                    Text(
                                      "Set - " +
                                          setsAndReps[t].setNumber.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Reps - " +
                                          setsAndReps[t].numOfReps.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
