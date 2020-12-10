import 'MapsScreen.dart';
import 'package:flutter/material.dart';
import 'WalkingScreen.dart';

class CardioScreen extends StatelessWidget {
  static const routeName = 'CardioScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //      title: Text('Cardio'),
        //    ),
        body: Column(
      children: <Widget>[
        Stack(children: [
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
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.asset(
                'assets/runTile.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 30.0,
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
          Positioned(
            left: 16,
            top: 320,
            child: Text(
              'What would you like\nto do today?',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ]),
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
