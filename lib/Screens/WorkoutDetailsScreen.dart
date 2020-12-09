import 'package:flutter/material.dart';
import '../Providers/WorkoutLogModel.dart';

class WorkoutDetailScreen extends StatelessWidget {
  static const routeName = '\WorkouDetailsScreen';
  @override
  Widget build(BuildContext context) {
    final List<WorkoutLogModel> listOfSetsAndReps =
        ModalRoute.of(context).settings.arguments as List<WorkoutLogModel>;
    print(listOfSetsAndReps.length);
    return Scaffold(
        appBar: AppBar(
          title: Text("Workout Details"),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: listOfSetsAndReps.length,
              itemBuilder: (ctx, i) => Card(
                    elevation: 10,
                    margin: EdgeInsets.all(5),
                    shadowColor: Colors.black,
                    color: Theme.of(context).primaryColor,
                    child: ListTile(
                      title: Text(
                        listOfSetsAndReps[i].exerciseName,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                              "Set " +
                                  listOfSetsAndReps[i].setNumber.toString() +
                                  " | ",
                              style: TextStyle(color: Colors.white)),
                          Text(
                              "Reps " +
                                  listOfSetsAndReps[i].numOfReps.toString(),
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  )),
        ));
  }
}
