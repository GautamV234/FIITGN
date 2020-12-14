import 'package:flutter/material.dart';
import '../Providers/WorkoutDataProvider.dart';
import 'package:provider/provider.dart';
import '../Providers/WorkoutDataModel.dart';
import '../Providers/WorkoutLogModel.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'WorkoutDetailsScreen.dart';

class WorkoutStatScreen extends StatefulWidget {
  static const routeName = '\WorkoutStatsScreen';

  @override
  _WorkoutStatScreenState createState() => _WorkoutStatScreenState();
}

class _WorkoutStatScreenState extends State<WorkoutStatScreen> {
  var isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit = true) {
      Provider.of<WorkoutDataProvider>(context).getWorkoutStatsFromDB();
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final workoutDataProvider = Provider.of<WorkoutDataProvider>(context);
    final List<WorkoutDataModel> listOfYourWorkouts =
        workoutDataProvider.yourWorkouts;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Workout Stats"),
      ),
      body: listOfYourWorkouts.length == 0
          ? Center(
              child: Text('No Workouts Yet! Time to Work!'),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: listOfYourWorkouts.length,
                itemBuilder: (ctx, i) {
                  final List<WorkoutLogModel> listOfSetsReps =
                      listOfYourWorkouts[i].listOfSetsReps;

                  final dateToDisplay =
                      DateTime.parse(listOfYourWorkouts[i].date);
                  final dateOfWorkout =
                      DateFormat.MMMMEEEEd().format(dateToDisplay);
                  final planName = listOfYourWorkouts[i].planName;
                  return GestureDetector(
                    onTap: () {
                      // go to details of workout screen
                      Navigator.of(context).pushNamed(
                          WorkoutDetailScreen.routeName,
                          arguments: listOfSetsReps);
                    },
                    child: Card(
                      elevation: 10,
                      margin: EdgeInsets.all(5),
                      shadowColor: Colors.black,
                      color: Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.calendar,
                              color: Colors.black,
                            ),
                            title: Text(
                              dateOfWorkout,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 5,
                            color: Colors.black,
                          ),
                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.bullseye,
                              color: Colors.black,
                            ),
                            title: Text(
                              planName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          ListTile(
                            // leading: FaIcon(
                            // FontAwesomeIcons.bookOpen,
                            // color: Colors.white,

                            trailing: FlatButton(
                              height: 10,
                              color: Colors.grey[200],
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "See Workout",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
