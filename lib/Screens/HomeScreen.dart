import 'package:Fiitgn1/Screens/finalAuthentication.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CardioScreen.dart';
import 'YourRunsStatsScreen.dart';
import '../Widgets/HomeScreenItem.dart';
import 'workoutScreen.dart';
import 'WorkoutStatsScreen.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  final List<IconData> rowOfItem = [
    FontAwesomeIcons.signOutAlt,
    FontAwesomeIcons.user,
  ];
  Future<bool> _onBackPressed(BuildContext ctx) {
    return showDialog(
        context: ctx,
        builder: (_) {
          return AlertDialog(
            title: Text('Exit App?'),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                  SystemNavigator.pop();
                },
                child: Text('Yes'),
              ),
              // FlatButton(
              //   onPressed: () {
              //     Navigator.of(ctx).pop(true);
              //   },
              //   child: Text('No'),
              // ),
            ],
          );
        });
  }

  Widget buildIcon(int index, BuildContext context) {
    return InkWell(
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
                      child: Text('Yes'),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Text('No'),
                    )
                  ],
                ));
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          rowOfItem[index],
          size: 25.0,
          color: Colors.blue[300],
        ),
      ),
    );
  }

  final List homeScreenList = [
    {
      'title': 'Start an Activity',
      'url': 'assets/runTile.jpg',
      'routeName': CardioScreen.routeName,
      'description':
          'Various activites like running and cycling can be accessed from here. Get out there and get those legs working!'
    },
    {
      'title': 'Your Activities',
      'url': 'assets/statsTile1.png',
      'routeName': YourRuns.routeName,
      'description':
          'Your running statistics can be seen here. Keep a watch and aim to reach higher and higher everyday.'
    },
    {
      'title': 'Workout',
      'url': 'assets/Workout.gif',
      'routeName': WorkoutHomeScreen.routeName,
      'description':
          'Had a quick warmup or a gruelling cardio session? Whichever it is, record it here and keep a tab on all those calories you are burning!'
    },
    {
      'title': 'Workout Stats',
      'url': 'assets/WorkoutStats2.gif',
      'routeName': WorkoutStatScreen.routeName,
      'description': 'Getting a bit redundant gotta think new here',
    },
    {
      'title': 'Work In Progress',
      'url': 'assets/comingSoonTile.png',
      'routeName': 'None',
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!'
    },
    {
      'title': 'Work In Progress',
      'url': 'assets/comingSoonTile.png',
      'routeName': 'None',
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
    },
  ];
  // String uid;
  // HomeScreen({@required this.uid});
  @override
  static const routeName = '\HomeScreen';
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context);
    print(deviceSize);
    return Scaffold(
      // backgroundColor: Colors.black,
      // appBar: AppBar(
      //   leading: InkWell(
      //     child: Icon(Icons.backspace_outlined),
      //     // child: Icon(Icons.exit_to_app),
      //     onTap: () {
      //       showDialog(
      //           context: context,
      //           builder: (ctx) => AlertDialog(
      //                 title: Text('Do you Want to Logout?'),
      //                 actions: <Widget>[
      //                   FlatButton(
      //                     onPressed: () {
      //                       logoutUser();
      //                     },
      //                     child: Text('Yes'),
      //                   ),
      //                   FlatButton(
      //                       onPressed: () {
      //                         Navigator.of(ctx).pop(true);
      //                       },
      //                       child: Text('No'))
      //                 ],
      //               ));
      //     },
      //   ),
      // leading: GestureDetector(
      // child: Icon(
      // Icons.logout,
      // ),
      // onTap: () => signOutUser().whenComplete(
      //   () => SystemNavigator.pop(),
      // ),
      // ),
      // title: Text('FIITGN'),
      // elevation: 12,
      // ),
      body: WillPopScope(
        onWillPop: () => _onBackPressed(context),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 120.0),
                child: Text(
                  'FIITGN',
                  style: TextStyle(
                    fontSize: deviceSize.size.width / 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 120.0),
                child: Text(
                  'THE COMPLETE FITNESS APP',
                  style: TextStyle(
                    fontSize: deviceSize.size.width / 20,
                  ),
                ),
              ),
              SizedBox(height: deviceSize.size.width / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  buildIcon(1, context),
                  buildIcon(0, context),
                ],
              ),
              SizedBox(
                height: deviceSize.size.width / 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: homeScreenList.length,
                itemBuilder: (ctx, i) => HomeScreenItem(
                  routeName: homeScreenList[i]['routeName'],
                  title: homeScreenList[i]['title'],
                  url: homeScreenList[i]['url'],
                  description: homeScreenList[i]['description'],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
