import 'MapsScreen.dart';
import 'package:flutter/material.dart';
import 'WalkingScreen.dart';

class CardioScreen extends StatelessWidget {
  static const routeName = 'CardioScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cardio'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: ListTile(
                trailing: Icon(Icons.run_circle),
                title: Text(
                  'Running',
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(MapScreen.routeName);
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(50.0),
            //   child: ListTile(
            //     trailing: Icon(Icons.directions_walk_sharp),
            //     title: Text(
            //       'Walking',
            //     ),
            //     onTap: () {
            //       Navigator.of(context).pushNamed(StepCounterScreen.routeName);
            //     },
            //   ),
            // ),
          ],
        ));
  }
}
