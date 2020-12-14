import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Providers/RunModel.dart';
import 'package:provider/provider.dart';
import '../Providers/RunDataProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'YourRunsPolyLines.dart';

class YourRuns extends StatefulWidget {
  static const routeName = 'YourRunsScreen';

  @override
  _YourRunsState createState() => _YourRunsState();
}

class _YourRunsState extends State<YourRuns> {
  var isInit = true;
  // @override
  // void initState() {
  //   Provider.of<RunDataProvider>(context, listen: false).getRunStatsFromDb();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<RunDataProvider>(context).getRunStatsFromDb();
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final runStatsProvider = Provider.of<RunDataProvider>(context);
    final List<RunModel> runStats = runStatsProvider.yourRunsList;
    print(runStats);
    // final temp = runStatsProvider.getRunStatsFromDb();
    return runStats.length == 0
        ? Scaffold(
            appBar: AppBar(
              title: Text('Run Stats'),
              elevation: 10,
            ),
            body: Center(
              child: Text('No Runs Yet! Time to Run!'),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Run Stats'),
              elevation: 10,
            ),
            body: ListView.builder(
              itemBuilder: (ctx, i) {
                String distance = runStats[i].distanceCovered;
                String avgSpeed = runStats[i].avgSpeed;
                return GestureDetector(
                  onTap: () {
                    //  go to the Show Polylines Screen

                    Navigator.pushNamed(
                        context, YourRunPolyLineScreen.routeName,
                        arguments: i); // passing the index
                  },
                  child: Card(
                    elevation: 10,
                    margin: EdgeInsets.all(5),
                    shadowColor: Colors.black,
                    // child: Container(
                    //   height: MediaQuery.of(context).size.height / 3,
                    child: Column(
                      children: [
                        ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.calendar,
                            color: Colors.black,
                          ),
                          title: runStats[i].dateOfRun == null
                              ? Text("Problem")
                              : Text(
                                  DateFormat.MMMMEEEEd()
                                      .format(
                                          DateTime.parse(runStats[i].dateOfRun))
                                      .toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'DISTANCE',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text('$distance'),
                                      Text('kilometres')
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    children: [
                                      Text(
                                        'SPEED',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text('$avgSpeed'),
                                      Text('KMPH')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text(''),
                          ],
                        ),
                        // ListTile(
                        //   leading: FaIcon(
                        //     FontAwesomeIcons.road,
                        //     color: Colors.black,
                        //   ),
                        //   title: Text("$distance kms",
                        //       style: TextStyle(color: Colors.black)),
                        // ),
                        // ListTile(
                        //   leading: FaIcon(
                        //     FontAwesomeIcons.tachometerAlt,
                        //     color: Colors.black,
                        //   ),
                        //   title: Text("$avgSpeed m/s",
                        //       style: TextStyle(color: Colors.black)),
                        // ),

                        ListTile(
                          trailing: FlatButton(
                            color: Colors.grey[300],
                            height: 10,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, YourRunPolyLineScreen.routeName,
                                  arguments: i); // passing the index
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'See Run',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: runStats.length,
            ),
          );
  }
}
