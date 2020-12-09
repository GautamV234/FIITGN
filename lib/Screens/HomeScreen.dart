import 'package:Fiitgn1/Screens/finalAuthentication.dart';
import 'package:flutter/material.dart';
import 'CardioScreen.dart';
import 'YourRunsStatsScreen.dart';
import '../Widgets/HomeScreenItem.dart';
import 'workoutScreen.dart';
import 'WorkoutStatsScreen.dart';

class HomeScreen extends StatelessWidget {
  final List homeScreenList = [
    {
      'title': 'Go for A Run',
      'url': 'assets/runTile.jpg',
      'routeName': CardioScreen.routeName
    },
    {
      'title': 'Your Runs',
      'url': 'assets/statsTile1.png',
      'routeName': YourRuns.routeName
    },
    {
      'title': 'Workout',
      'url': 'assets/Workout.gif',
      'routeName': WorkoutHomeScreen.routeName,
    },
    {
      'title': 'Workout Stats',
      'url': 'assets/WorkoutStats2.gif',
      'routeName': WorkoutStatScreen.routeName,
    },
    {
      'title': 'Work In Progress',
      'url': 'assets/comingSoonTile.png',
      'routeName': 'None',
    },
    {
      'title': 'Work In Progress',
      'url': 'assets/comingSoonTile.png',
      'routeName': 'None',
    },
  ];
  // String uid;
  // HomeScreen({@required this.uid});
  @override
  static const routeName = '\HomeScreen';
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        leading: InkWell(
          // child: Icon(Icons.backspace_outlined),
          child: Icon(Icons.exit_to_app),
          onTap: () {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: Text('Do you Want to Logout?'),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              logoutUser();
                            },
                            child: Text('Yes')),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(true);
                            },
                            child: Text('No'))
                      ],
                    ));
          },
        ),

        // leading: GestureDetector(
        //   child: Icon(
        //     Icons.logout,
        //   ),
        //   // onTap: () => signOutUser().whenComplete(
        //   //   () => SystemNavigator.pop(),
        //   // ),
        // ),
        title: Text('FIITGN'),
        elevation: 12,
      ),
      body: ListView.builder(
        itemCount: homeScreenList.length,
        itemBuilder: (ctx, i) => HomeScreenItem(
          routeName: homeScreenList[i]['routeName'],
          title: homeScreenList[i]['title'],
          url: homeScreenList[i]['url'],
        ),
      ),
    );
  }
}
