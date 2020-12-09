import 'package:Fiitgn1/Providers/PlanModel.dart';
import 'package:flutter/material.dart';
import '../Providers/WorkoutDataProvider.dart';
import 'package:provider/provider.dart';
import '../Providers/PlanModel.dart';

class CustomPlansScreen extends StatelessWidget {
  static const routeName = '\customPlansScreen';
  @override
  Widget build(BuildContext context) {
    final workoutDataProvider = Provider.of<WorkoutDataProvider>(context);
    final List<PlanModel> customPlansList = workoutDataProvider.customPlans;

    // make a widget later for the UI aspect of the list
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text('Custom Plans'),
      ),
      body: ListView.builder(
        itemCount: customPlansList.length,
        itemBuilder: (_, i) => Container(
          padding: EdgeInsets.all(20),
          color: Colors.black,
          child: Column(
            children: [
              Text(
                customPlansList[i].planName,
                style: TextStyle(color: Colors.white),
              ),
              RaisedButton(
                elevation: 10,
                onPressed: () async {
                  await workoutDataProvider
                      .makeCurrentPlan(customPlansList[i].planName);
                  Navigator.pop(context);
                },
                child: Text('Make Current Plan'),
              ),
              SizedBox(height: 20),
            ],
          ),
          //  agar plan name aaraha hai toh baaki things can also be outputted think about that later
        ),
      ),
    );
  }
}
