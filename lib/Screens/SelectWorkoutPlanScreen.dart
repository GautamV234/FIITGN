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

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: MediaQuery.of(context).size.width / 13.5,
                    color: Colors.black,
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 120.0, bottom: 20),
              child: Text(
                'Custom Plans',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 10.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true, physics: ScrollPhysics(),
              //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 1, mainAxisSpacing: 10),
              itemCount: customPlansList.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.all(1),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ClipRRect(
                      child: Image(
                        width: MediaQuery.of(context).size.width,
                        image: AssetImage(
                            'assets/fitnessPlan2.jpg'), //acess plan ka image, and a nice description for it
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width / 29.3,
                      bottom: MediaQuery.of(context).size.height / 43.8,
                      child: RaisedButton(
                        onPressed: () async {
                          workoutDataProvider // add await in case when I add shared pref
                              .makeCurrentPlan(customPlansList[i].planName);
                          Navigator.pop(context);
                        },
                        child: Text('Make Current Plan'),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height / 12.5,
                      left: MediaQuery.of(context).size.width / 29.3,
                      child: Text(
                        customPlansList[i].planName,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 8.3),
                      ),
                    ),
                  ],
                ),
                //   SizedBox(height: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
