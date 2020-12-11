import 'package:flutter/material.dart';
import 'SelectWorkoutPlanScreen.dart';
import './NoWorkoutPlanSelectedScreen.dart';
import '../Screens/workoutLoggingScreen.dart';
import 'package:provider/provider.dart';
import '../Providers/WorkoutDataProvider.dart';

class WorkoutHomeScreen extends StatelessWidget {
  static const routeName = '\workoutScreen';
  String workoutPlanName = "";
  final List workoutScreenList = [
    {
      'title': 'Start Workout',
      'url': 'assets/WorkoutTabs.jpg',
      'routeName': WorkoutLoggingScreen.routeName,
    },
    {
      'title': 'Custom Plans',
      'url': 'assets/WorkoutTabs.jpg',
      'routeName': CustomPlansScreen.routeName,
    },
    {
      'title': 'Create Plan',
      'url': 'assets/WorkoutTabs.jpg',
      'routeName': " ",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final workoutDataProvider = Provider.of<WorkoutDataProvider>(context);
    return Scaffold(
      // backgroundColor: Colors.black,
      //  appBar: AppBar(
      //     title: Text('Workout'),
      //      elevation: 12,
      //    ),
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(
                    'assets/Workout.gif',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 40,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: MediaQuery.of(context).size.width / 13.5,
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 25.5,
                bottom: MediaQuery.of(context).size.height / 29.22,
                child: Text(
                  'Choose a plan.\nStart your workout!',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 10.3,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  InkWell(
                    onTap: () async {
                      //// add code to verify from Shared Pref to check if plan already selected
                      workoutPlanName =
                          await workoutDataProvider.getCurrentPlan;
                      if (workoutPlanName == "") {
                        Navigator.pushNamed(
                            context, NoWorkoutPlanSelectedScreen.routeName);
                      } else {
                        print("Plan was already Set");
                        Navigator.pushNamed(
                            context, WorkoutLoggingScreen.routeName,
                            arguments: workoutPlanName);
                      }
                    },
                    child: ListTile(
                      title: Text('Start Working out'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, CustomPlansScreen.routeName);
                    },
                    child: ListTile(
                      title: Text('Select Workout Plan'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //  feature to be added later
                    },
                    child: ListTile(
                      title: Text('Create Plan'),
                    ),
                  ),
                ],
              ),
              // child: ListView(children: [
              //   ListView.builder(
              //     shrinkWrap: true,
              //     physics: ScrollPhysics(),
              //     itemCount: workoutScreenList.length,
              //     itemBuilder: (ctx, i) => HomeScreenItem(
              //       routeName: workoutScreenList[i]['routeName'],
              //       title: workoutScreenList[i]['title'],
              //       url: workoutScreenList[i]['url'],
              //       description: "",
              //     ),
              //   ),
              // ]),
            ),
          )
        ],
      ),
    );
  }
}
