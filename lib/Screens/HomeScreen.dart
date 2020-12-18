import 'package:Fiitgn1/Screens/MapsScreen.dart';
import 'package:Fiitgn1/Screens/finalAuthentication.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Screens/CycleScreen.dart';
import '../Widgets/HomeScreenItem.dart';
import 'workoutScreen.dart';
import 'package:flutter/services.dart';
import './StatsScreen.dart';

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
                  // Navigator.of(ctx).pop(true);
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
      'title': 'Start Running',
      'url': 'assets/runTile.jpg',
      'routeName': MapScreen.routeName,
      'description':
          'Running can be accessed from here. Get out there and get those legs working!',
      'heroID': 1,
    },
    {
      'title': 'Start Cycling',
      'url': 'assets/newActivity.jpeg',
      'routeName': CycleScreen.routeName,
      'description':
          'Cycling can be accessed from here. Get out there and get those legs working!',
      'heroID': 2,
    },
    {
      'title': 'Workout',
      'url': 'assets/Workout.jpeg',
      'routeName': WorkoutHomeScreen.routeName,
      'description':
          'Had a quick warmup or a gruelling cardio session? Whichever it is, record it here and keep a tab on all those calories you are burning!',
      'heroID': 3,
    },
    {
      'title': 'Your Activities',
      'url': 'assets/statsTile2.jpeg',
      'routeName': StatsScreen.routeName,
      'description':
          'Your running statistics can be seen here. Keep a watch and aim to reach higher and higher everyday.',
      'heroID': 4,
    },
    {
      'title': 'Running Buddy',
      'url': 'assets/runBud.jpg',
      'routeName': '',
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 5,
    },
    {
      'title': 'Know Your Mess',
      'url': 'assets/iitgnMess.jpg',
      'routeName': '',
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 6,
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
      backgroundColor: Color(0xFFDDDDDD),
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
                  heroID: homeScreenList[i]['heroID'],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
