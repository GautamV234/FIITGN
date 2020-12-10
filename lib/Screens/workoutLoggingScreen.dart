import 'package:Fiitgn1/Providers/ExerciseModel.dart';
import 'package:Fiitgn1/Providers/PlanModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    String currentPlanName =
        "Madhu's Plan"; // this has been done only for development

    // currentPlanName = workoutDataProvider.currentPlan; //  this has been done only for development make changes again without fail
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
        //  appBar: AppBar(
        //    title: currentPlanName == "" ? null : Text(currentPlanName),
        //    actions: [
        //      IconButton(
        //        icon: Icon(Icons.save_sharp),
        //        onPressed: () =>
        //            saveData(uid, dateIso, setsAndReps, currentPlanName),
        //      )
        //    ], // ADD SAVING LOGIC LATER IN THE OTHER PAGE OF PAGE VIEW AKA BOTTOM
        //  ),
        body: currentPlanName == ""
            ? Center(
                child: Text('No Plan Selected'),
              )
            : PageView(
                children: [
                  ListView(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: currentExerciseModel.length,
                              itemBuilder: (ctx, index) => Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                  ),
                                  ClipRRect(
                                    child: currentExerciseModel[index]
                                                .assetImageUrl ==
                                            null
                                        ? Text('No Image yet')
                                        : Image.asset(
                                            currentExerciseModel[index]
                                                .assetImageUrl,
                                            height: 300,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    bottom: 15,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          currentExerciseModel[index]
                                              .exerciseName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 30),
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
                                                            Text(
                                                                "Add Set Number"),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
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
                                                            Text(
                                                                "Add rep count"),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
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
                                                            print(index
                                                                    .toString() +
                                                                " this is the value of i ");
                                                            String
                                                                currentExerciseName =
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
                                                            Navigator.of(ctx)
                                                                .pop(true);

                                                            setsAndReps.forEach(
                                                              (element) {
                                                                if (element
                                                                        .exerciseName ==
                                                                    currentExerciseName) {
                                                                  workoutList.add(
                                                                      element);
                                                                  print(workoutList[
                                                                      workoutList
                                                                              .length -
                                                                          1]);
                                                                  setState(
                                                                      () {});
                                                                }
                                                              },
                                                            );
                                                            // testing
                                                            print(index
                                                                    .toString() +
                                                                " val of i after popping");
                                                            print(setsAndReps
                                                                    .length
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Theme.of(context).accentColor,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Workout Details",
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: setsAndReps.length,
                            itemBuilder: (ctx, t) {
                              print("abcde");
                              return Stack(children: [
                                ClipRRect(
                                  child: Image(
                                    image: AssetImage(
                                      currentExerciseModel
                                          .firstWhere((element) =>
                                              element.exerciseName ==
                                              setsAndReps[t].exerciseName)
                                          .assetImageUrl,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                  height: 120,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          setsAndReps[t].exerciseName,
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "Set - " +
                                                    setsAndReps[t]
                                                        .setNumber
                                                        .toString(),
                                                style: TextStyle(fontSize: 18)),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "|",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Reps - " +
                                                  setsAndReps[t]
                                                      .numOfReps
                                                      .toString(),
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //     ClipRRect(
                                //       borderRadius: BorderRadius.circular(20.0),
                                //     child: Image(
                                //       width: 110,
                                //     ),
                                //    title: Text(setsAndReps[t].exerciseName),
                                //  subtitle: Column(
                                //  children: [
                                //     Text(
                                //       "Set - " +
                                //           setsAndReps[t].setNumber.toString(),
                                //       style: TextStyle(
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //     Text(
                                //     "Reps - " +
                                //       setsAndReps[t].numOfReps.toString(),
                                //  style: TextStyle(
                                //         fontWeight: FontWeight.bold),
                                //  ),
                                //         ],
                              ]);
                              //  );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
