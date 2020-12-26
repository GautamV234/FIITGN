// import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/services.dart';
import 'dart:math';
import 'ShowRunResults.dart';

import 'package:background_location/background_location.dart' as bLoc;

class MapScreen extends StatefulWidget {
  static const routeName = 'NewMapScreen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  int finishFlag = 0; // flag to check if finish should be showed or no
  String apiKey = 'AIzaSyDkyZ5LN0apdkxOHnRbR-qHY3Hw3uqs1-s';
  bool isChanged = false;
  DateTime startingTime;
  DateTime endingTime;
  double storeInitialLat;
  double storeInitialLong;
  double storeFinalLat;
  double storeFinalLong;
  double initialLatitude;
  double initialLongitude;
  double finalLatitude;
  double finalLongitude;
  DateTime dateToShowOnScreen = DateTime.now();
  List<Map<String, double>> listOfLatLngForPoly = [];
  Map<dynamic, dynamic> passingToShowResults = Map();
  int flag = 0;
  int iter = 1;
  double distance = 0;
  double speedThreshold = 1.0;
  int buttonFlag = 0;
  String dist = "";
  String speedString = "";

  StreamSubscription _locationSubscription;
  GoogleMapController _controller;
  loc.Location _locationTracker = loc.Location();
  Marker marker;
  Circle circle;
  // PolylinePoints polylinePoints = PolylinePoints();
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  // setting initial Camera Position at Panchayat Circle
  static final CameraPosition initialPosition = CameraPosition(
    target: LatLng(23.210672, 72.684402),
    zoom: 18.00,
  );

  void updateMarkerAndCircle(double latitude, double longitude) {
    // print("newLocalData type is" + newLocalData.runtimeType.toString());
    LatLng latlng = LatLng(latitude, longitude);
    this.setState(
      () {
        // marker = Marker(
        //   markerId: MarkerId("home"),
        //   visible: false,
        //   position: latlng,
        //   rotation: newLocalData.heading,
        //   draggable: false,
        //   zIndex: 2,
        //   flat: true,
        //   anchor: Offset(0.5, 0.5),
        // );
        circle = Circle(
          circleId: CircleId("car"),
          radius: 2,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70),
        );
      },
    );
  }

  double distanceCovered(double initialLatitude, double initialLongitude,
      double finalLatitude, double finalLongitude) {
    // converting all values to radians
    double lat1 = initialLatitude / 57.29577951;
    initialLongitude = initialLongitude / 57.29577951;
    double lat2 = finalLatitude / 57.29577951;
    finalLongitude = finalLongitude / 57.29577951;
    double dlat = lat2 - lat1;
    double dlon = finalLongitude - initialLongitude;
    // finding distance in Kms using Haversine formula
    double a =
        pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
    double c = 2 * asin(sqrt(a));

    double r = 6371; // radius of Earth in Kms
    double distance = r * c;
    return (distance);
  }

  void getCurrentLocation() async {
    try {
      loc.LocationData location = await _locationTracker.getLocation();
      // print("location gotten");
      await bLoc.BackgroundLocation.setNotificationTitle(
          "FIITGN is running in the background");
      await bLoc.BackgroundLocation.startLocationService();
      // print('location services started');
      updateMarkerAndCircle(location.latitude, location.longitude);
      isChanged = true;
      if (flag == 0) {
        initialLatitude = location.latitude;
        initialLongitude = location.longitude;

        //  storing initial Location
        storeInitialLat = initialLatitude;
        storeInitialLong = initialLongitude;
        setState(() {
          finishFlag = 1; // flag to check if finish should be showed or no
        });
        listOfLatLngForPoly
            .add({'latitude': storeInitialLat, 'longitude': storeInitialLong});
        startingTime = DateTime.now();
        print("starting Time is " + startingTime.toString());
        // print("This portion is being run");
        flag = 1;
      }
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      // print("stream beginning");
      bLoc.BackgroundLocation.getLocationUpdates((location) {
        // print("code entered the stream");
        if (_controller != null) {
          // print("stream going on");
          _controller.animateCamera(
            CameraUpdate.newCameraPosition(
              new CameraPosition(
                  target: LatLng(location.latitude, location.longitude),
                  bearing: 192.232,
                  tilt: 0,
                  zoom: 18.00),
            ),
          );
        }
        updateMarkerAndCircle(location.latitude, location.longitude);
        finalLatitude = location.latitude;
        finalLongitude = location.longitude;
        // if (location.speed <= speedThreshold) {
        // print("speed too slow to count distance");
        // } else {
        distance = distance +
            distanceCovered(initialLatitude, initialLongitude, finalLatitude,
                finalLongitude);
        // }
        // print("Distance is $dist metres");
        double speed = location.speed;
        speedString = speed.toStringAsFixed(1);

        dist = distance.toStringAsFixed(2);
        initialLatitude = finalLatitude;
        initialLongitude = finalLongitude;
        // listOfLatLngForPoly.add(LatLng(initialLatitude, initialLongitude));
        listOfLatLngForPoly
            .add({'latitude': initialLatitude, 'longitude': initialLongitude});
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  void endRun() {}

  _showSnackBar() {
    print("a");
    final snackBar = SnackBar(content: Text("Sorry! Back button is disabled"));
    key.currentState.showSnackBar(snackBar);
    print('b');
  }

  Future<bool> _onBackPressed() {
    // print("Checing connection");
    // await _showSnackBar(key);
    // print("After function");
    return Future<bool>.value(false);
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      // print("Heeheehaa");
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var date2 = DateTime.now();
    // String differenceSecs = '';
    // if (startingTime != null)
    // differenceSecs = date2.difference(startingTime).inSeconds.toString();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        key: key,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   actions: [],
        //   title: Text('Track Your Run'),
        // ),
        body: WillPopScope(
          onWillPop: () {
            _showSnackBar();
            return _onBackPressed();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height / 20,
                // ),
                Container(
                  //  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF145374), Colors.white],
                    ),
                  ),
                  //  color: Colors.black,
                  height: MediaQuery.of(context).size.height / 5.5,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width / 20,
                        MediaQuery.of(context).size.width / 10,
                        0,
                        0),
                    child: Row(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height / 11,
                            child: Image.asset('assets/10765.png')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 7,
                        ),
                        Text(
                          'Running',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway',
                              fontSize: MediaQuery.of(context).size.width / 12),
                        )
                        // FloatingActionButton(
                        //   backgroundColor: Colors.transparent,
                        //   onPressed: () {},
                        //   child: Icon(Icons.gps_fixed),
                        // )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    initialCameraPosition: initialPosition,
                    mapType: MapType.normal,
                    // markers: Set.of((marker != null) ? [marker] : []),
                    circles: Set.of((circle != null) ? [circle] : []),
                    polylines: _polylines,
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child:
                        // child: finishFlag == 1
                        //     ? Container()
                        Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 100,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height / 100)),
                            height: MediaQuery.of(context).size.height / 500,
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 80,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Padding(
                            //     padding: const EdgeInsets.all(10.0),
                            //     child:

                            finishFlag == 0
                                ? InkWell(
                                    onTap: getCurrentLocation,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              25,
                                      child: Text(
                                        'Start Run',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                30,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.green[300]),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          var actions2 = [
                                            FlatButton(
                                              onPressed: () {
                                                storeFinalLat = finalLatitude;
                                                storeFinalLong = finalLongitude;
                                                endingTime = DateTime.now();
                                                passingToShowResults[
                                                        'initialLat'] =
                                                    storeInitialLat;
                                                passingToShowResults[
                                                        'initialLong'] =
                                                    storeInitialLong;
                                                passingToShowResults[
                                                    'finalLat'] = storeFinalLat;
                                                passingToShowResults[
                                                        'finalLong'] =
                                                    storeFinalLong;
                                                passingToShowResults[
                                                        'initialTime'] =
                                                    startingTime;
                                                passingToShowResults[
                                                    'finalTime'] = endingTime;
                                                passingToShowResults[
                                                    'distance'] = distance;
                                                passingToShowResults[
                                                        'listOfLatLng'] =
                                                    listOfLatLngForPoly;

                                                // print("All parameters stored successfully");

                                                // _locationSubscription.cancel();
                                                bLoc.BackgroundLocation
                                                    .stopLocationService();
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        ShowResultsScreen
                                                            .routeName,
                                                        arguments:
                                                            passingToShowResults);
                                                // }
                                              },
                                              child: Text('Yes'),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop(true);
                                              },
                                              child: Text('No'),
                                            ),
                                          ];
                                          return AlertDialog(
                                            title: Text(
                                                'Are you sure you want to end Run?'),
                                            actions: actions2,
                                          );
                                        },
                                      );
                                    },
                                    child: finishFlag == 0
                                        ? Container()
                                        : Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                25,
                                            child: Text(
                                              'End Run',
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          30,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.red[200]),
                                          ),
                                  ),

                            Container(
                              child: Text(
                                dateToShowOnScreen == null
                                    ? ''
                                    : DateFormat.MMMMEEEEd()
                                        .format(dateToShowOnScreen)
                                        .toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Raleway',
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            50),
                              ),
                              //    color: Colors.white,
                              width: MediaQuery.of(context).size.width / 3,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 80,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width:
                                  (3 / 8) * (MediaQuery.of(context).size.width),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Text(
                                dist,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 7,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              width: (3 / 16) *
                                  (MediaQuery.of(context).size.width),
                              child: Center(
                                child: Text(
                                  'kms',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Raleway'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: (3 / 16) *
                                  (MediaQuery.of(context).size.width),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width:
                                  (3 / 8) * (MediaQuery.of(context).size.width),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Text(
                                speedString,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 7,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              width: (3 / 16) *
                                  (MediaQuery.of(context).size.width),
                              child: Center(
                                child: Text(
                                  'KMPH',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Raleway'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: (3 / 16) *
                                  (MediaQuery.of(context).size.width),
                            ),
                          ],
                        ),
                      ],
                    ),
                    //      color: Colors.green[300],
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              MediaQuery.of(context).size.width / 10),
                          topRight: Radius.circular(
                              MediaQuery.of(context).size.width / 10)),
                      color: Colors.grey[850],
                      // gradient: LinearGradient(
                      //   begin: Alignment.bottomCenter,
                      //   end: Alignment.topCenter,
                      //   colors: [Colors.red[200], Colors.white],
                      // ),
                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: InkWell(
                //     onTap: () {
                //       showDialog(
                //         context: context,
                //         builder: (ctx) {
                //           var actions2 = [
                //             FlatButton(
                //               onPressed: () {
                //                 storeFinalLat = finalLatitude;
                //                 storeFinalLong = finalLongitude;
                //                 endingTime = DateTime.now();
                //                 passingToShowResults['initialLat'] =
                //                     storeInitialLat;
                //                 passingToShowResults['initialLong'] =
                //                     storeInitialLong;
                //                 passingToShowResults['finalLat'] =
                //                     storeFinalLat;
                //                 passingToShowResults['finalLong'] =
                //                     storeFinalLong;
                //                 passingToShowResults['initialTime'] =
                //                     startingTime;
                //                 passingToShowResults['finalTime'] = endingTime;
                //                 passingToShowResults['distance'] = distance;
                //                 passingToShowResults['listOfLatLng'] =
                //                     listOfLatLngForPoly;

                //                 // print("All parameters stored successfully");

                //                 // _locationSubscription.cancel();
                //                 bLoc.BackgroundLocation.stopLocationService();
                //                 Navigator.of(context).pushReplacementNamed(
                //                     ShowResultsScreen.routeName,
                //                     arguments: passingToShowResults);
                //                 // }
                //               },
                //               child: Text('Yes'),
                //             ),
                //             FlatButton(
                //               onPressed: () {
                //                 Navigator.of(ctx).pop(true);
                //               },
                //               child: Text('No'),
                //             ),
                //           ];
                //           return AlertDialog(
                //             title: Text('Are you sure you want to end Run?'),
                //             actions: actions2,
                //           );
                //         },
                //       );
                //     },
                //     child: finishFlag == 0
                //         ? Container()
                //         : Container(
                //             alignment: Alignment.center,
                //             width: MediaQuery.of(context).size.width,
                //             height: MediaQuery.of(context).size.height / 25,
                //             child: Text(
                //               'Finish',
                //               style: TextStyle(
                //                   fontSize:
                //                       MediaQuery.of(context).size.height / 30,
                //                   fontWeight: FontWeight.w600),
                //             ),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(20),
                //                 color: Colors.red[200]),
                //           ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// finishFlag == 1
//     ? Container()
//     : Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: InkWell(
//           onTap: getCurrentLocation,
//           child: Container(
//             alignment: Alignment.center,
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height / 25,
//             child: Text(
//               'Start',
//               style: TextStyle(
//                   fontSize:
//                       MediaQuery.of(context).size.height / 30,
//                   fontWeight: FontWeight.w600),
//             ),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.blue[100]),
//           ),
//         )),
// FloatingActionButton(
//   child: Icon(Icons.location_searching),
//   onPressed: getCurrentLocation,
// ),
// Row(
//   children: [
//     Container(
//       child: Container(
//         child: Column(
//           children: [
//             Icon(
//               Icons.directions_run,
//               color: Colors.black,
//             ),
//             Text(
//               '$dist',
//               style: TextStyle(
//                   fontSize:
//                       MediaQuery.of(context).size.width / 7,
//                   fontWeight: FontWeight.w700),
//             ),
//             Text('METRES')
//           ],
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//         ),
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(color: Colors.grey[200], blurRadius: 5)
//           ],
//           borderRadius: BorderRadius.circular(30),
//           color: Colors.grey[200],
//         ),
//         margin: EdgeInsets.all(5),
//       ),
//       width: MediaQuery.of(context).size.width / 2,
//       height: MediaQuery.of(context).size.height / 6,
//       //  color: Colors.white,
//     ),
//     Container(
//       child: Container(
//         child: Column(
//           children: [
//             Icon(
//               Icons.speed,
//               color: Colors.black,
//             ),
//             Text(
//               '$speedString',
//               style: TextStyle(
//                   fontSize:
//                       MediaQuery.of(context).size.width / 7,
//                   fontWeight: FontWeight.w700),
//             ),
//             Text('KMPH')
//           ],
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//         ),
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(color: Colors.grey[200], blurRadius: 5)
//           ],
//           borderRadius: BorderRadius.circular(30),
//           color: Colors.grey[200],
//         ),
//         margin: EdgeInsets.all(5),
//       ),
//       height: MediaQuery.of(context).size.height / 6,
//       width: MediaQuery.of(context).size.width / 2,
//       //color: Colors.white,
//     ),
//   ],
// ),
