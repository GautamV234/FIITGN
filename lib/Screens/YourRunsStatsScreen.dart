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
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      child: Column(
                        children: [
                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.calendar,
                              color: Colors.white,
                            ),
                            title: runStats[i].dateOfRun == null
                                ? Text("Problem")
                                : Text(
                                    DateFormat.yMMMEd()
                                        .format(DateTime.parse(
                                            runStats[i].dateOfRun))
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.road,
                              color: Colors.white,
                            ),
                            title: Text("$distance kms",
                                style: TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.tachometerAlt,
                              color: Colors.white,
                            ),
                            title: Text("$avgSpeed m/s",
                                style: TextStyle(color: Colors.white)),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              'Tap to see your Run',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: runStats.length,
            ),
          );
  }
}
