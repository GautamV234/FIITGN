import 'package:Fiitgn1/Screens/MapsScreen.dart';
import 'package:Fiitgn1/Screens/finalAuthentication.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/CycleScreen.dart';
import '../Widgets/HomeScreenItem.dart';
import 'workoutScreen.dart';
import 'package:flutter/services.dart';
import './StatsScreen.dart';
import '../Providers/CycleDataProvider.dart';
import '../Providers/RunDataProvider.dart';
import '../Providers/WorkoutDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  static const routeName = '\HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  insideInIt() async {
    final runStatsProvider =
        Provider.of<RunDataProvider>(context, listen: false);
    final workoutStatsProvider =
        Provider.of<WorkoutDataProvider>(context, listen: false);
    final cycleStatsProvider =
        Provider.of<CycleDataProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    print('got instance');
    String uid = prefs.getString('uid');
    String token = prefs.getString('token');
    print('gotten uid is' + uid);
    print('gotten token is' + token);
    // String token = prefs.getString('token');
    runStatsProvider.setUid(uid);
    //
    runStatsProvider.setToken(token);
    workoutStatsProvider.setUid(uid);
    workoutStatsProvider.setToken(token);
    cycleStatsProvider.setUid(uid);
    cycleStatsProvider.setToken(token);
    print("Uids and tokens are set");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, insideInIt);
  }

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
                  print('Exiting App');
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
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('signedInStatus', false);
                        await prefs.setString('token', "");
                        await prefs.setString('uid', "");
                        print('checking this part');
                        print(prefs.getString('token'));
                        print("all awaits before logout completed");
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
      // child: Container(
      //   height: 60.0,
      //   width: 60.0,
      //   decoration: BoxDecoration(
      //     color: Color(0xFFE7EBEE),
      //     borderRadius: BorderRadius.circular(30.0),
      //   ),
      //   child: Icon(
      //     rowOfItem[index],
      //     size: 25.0,
      //     color: Colors.blue[300],
      //   ),
      // ),
    );
  }

  final List homeScreenList = [
    {
      'title': 'Start Running',
      'url': 'assets/10765.png',
      'routeName': MapScreen.routeName,
      'description':
          'Running can be accessed from here. Get out there and get those legs working!',
      'heroID': 1,
    },
    {
      'title': 'Start Cycling',
      'url': 'assets/11241.png',
      'routeName': CycleScreen.routeName,
      'description':
          'Cycling can be accessed from here. Get out there and get those legs working!',
      'heroID': 2,
    },
    {
      'title': 'Workout',
      'url': 'assets/4805.png',
      'routeName': WorkoutHomeScreen.routeName,
      'description':
          'Had a quick warmup or a gruelling cardio session? Whichever it is, record it here and keep a tab on all those calories you are burning!',
      'heroID': 3,
    },
    {
      'title': 'Your Activities',
      'url': 'assets/statLady.png',
      'routeName': StatsScreen.routeName,
      'description':
          'Your running statistics can be seen here. Keep a watch and aim to reach higher and higher everyday.',
      'heroID': 4,
    },
    {
      'title': 'Running Buddy',
      'url': 'assets/6517.png',
      'routeName': '',
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 5,
    },
    {
      'title': 'Know Your Diet',
      'url': 'assets/6569.png',
      'routeName': '',
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 6,
    },
  ];

  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context);
    print(deviceSize);
    return Scaffold(
      backgroundColor: Colors.white,
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
          child: Column(
            // padding: const EdgeInsets.symmetric(
            //   vertical: 20,
            // ),
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0, right: 120.0),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.teal[300], Colors.white],
                      ),
                    ),
                    // color: Colors.green[200],

                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width,
                    //       child: Image.asset(
                    //       'assets/homePage.jpg',
                    //     fit: BoxFit.cover,
                  ),
                  //   ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 20,
                    top: MediaQuery.of(context).size.height / 26,
                    child: Text(
                      'Hello.',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: deviceSize.size.width / 6.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 19,
                    top: MediaQuery.of(context).size.height / 8,
                    child: Text(
                      'Welcome to FIITGN.',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: deviceSize.size.width / 16,
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 25,
                    top: MediaQuery.of(context).size.height / 6,
                    child: Container(
                      child: IconButton(
                        icon: Icon(FontAwesomeIcons.signOutAlt),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: Text('Do you want to Logout?'),
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
                      ),
                    ),
                  )
                  // SignInButtonBuilder(
                  //   text: 'LOGOUT',
                  //   icon: FontAwesomeIcons.signOutAlt,
                  //   onPressed: () {
                  //     showDialog(
                  //         context: context,
                  //         builder: (ctx) => AlertDialog(
                  //               title: Text('Do you want to Logout?'),
                  //               actions: <Widget>[
                  //                 FlatButton(
                  //                   onPressed: () {
                  //                     logoutUser();
                  //                   },
                  //                   child: Text('Yes'),
                  //                 ),
                  //                 FlatButton(
                  //                   onPressed: () {
                  //                     Navigator.of(ctx).pop(true);
                  //                   },
                  //                   child: Text('No'),
                  //                 )
                  //               ],
                  //             ));
                  //   },
                  //   backgroundColor: Colors.transparent,
                  // ),
                ],
              ),
              // Text(
              //   'FIITGN',
              //   style: TextStyle(
              //     fontFamily: 'LemonMilk',
              //     fontSize: deviceSize.size.width / 8,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),

              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0, right: 120.0),
              //   child: Text(
              //     'THE COMPLETE FITNESS APP',
              //     style: TextStyle(
              //       fontFamily: 'Raleway',
              //       fontSize: deviceSize.size.width / 20,
              //     ),
              //   ),
              // ),
              //    SizedBox(height: deviceSize.size.width / 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: <Widget>[
              //     buildIcon(1, context),
              //     buildIcon(0, context),
              //   ],
              // ),
              // SizedBox(
              //   height: deviceSize.size.width / 16,
              // ),
              Expanded(
                child: Container(
                  child: //GridView(
                      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //         crossAxisCount: 2),
                      //     children: [
                      GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing:
                            MediaQuery.of(context).size.height / 80),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
