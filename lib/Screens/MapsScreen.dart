import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'ShowRunResults.dart';

class MapScreen extends StatefulWidget {
  static const routeName = 'MapScreen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  int finishFlag = 0;
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
  Location _locationTracker = Location();
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

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/runMan.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(
      () {
        marker = Marker(
          markerId: MarkerId("home"),
          visible: false,
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData),
        );
        // print("Marker is made");
        circle = Circle(
          circleId: CircleId("car"),
          radius: 2,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70),
        );
        // print("Circle is made");
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
      Uint8List imageData = await getMarker();
      // print("Image is loaded");
      var location = await _locationTracker.getLocation();
      // print("Location is loaded");
      // print(location);
      updateMarkerAndCircle(location, imageData);
      isChanged = true;
      if (flag == 0) {
        initialLatitude = location.latitude;
        initialLongitude = location.longitude;

        //  storing initial Location
        storeInitialLat = initialLatitude;
        storeInitialLong = initialLongitude;
        setState(() {
          finishFlag = 1;
        });
        listOfLatLngForPoly
            .add({'latitude': storeInitialLat, 'longitude': storeInitialLong});
        // listOfLatLngForPoly.add(LatLng(storeInitialLat, storeInitialLong));
        startingTime = DateTime.now();
        print("This portion is being run");
        flag = 1;
      }
      if (_locationSubscription != null) {
        print("Yo Yo Yo");
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged().listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(
            CameraUpdate.newCameraPosition(
              new CameraPosition(
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  bearing: 192.232,
                  tilt: 0,
                  zoom: 18.00),
            ),
          );
        }
        updateMarkerAndCircle(newLocalData, imageData);
        finalLatitude = newLocalData.latitude;
        finalLongitude = newLocalData.longitude;

        // LatLng initialLatLng = LatLng(initialLatitude, initialLongitude);
        // LatLng finalLatLng = LatLng(finalLatitude, finalLongitude);
        // print("$initialLatLng $finalLatLng");

        // updatePolyLines(
        //   initialLatitude,
        //   initialLongitude,
        //   finalLatitude,
        //   finalLongitude,
        // );

        if (newLocalData.speed <= speedThreshold) {
          // print(newLocalData.speed.toString());
          print("speed too slow to count distance");
          // dont increase distance
        } else {
          distance = distance +
              distanceCovered(initialLatitude, initialLongitude, finalLatitude,
                      finalLongitude) *
                  1000;
        }

        print("Distance is $dist metres");
        double speed = newLocalData.speed;
        print("Speed is $speedString");
        speedString = speed.toStringAsFixed(2);
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

  _showSnackBar() {
    print("a");
    final snackBar = SnackBar(content: Text("Sorry! Back button is disabled"));
    key.currentState.showSnackBar(snackBar);
    print('b');
  }

  Future<bool> _onBackPressed() {
    print("Checing connection");
    // await _showSnackBar(key);
    print("After function");
    return Future<bool>.value(false);
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      print("Heeheehaa");
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  initialCameraPosition: initialPosition,
                  mapType: MapType.normal,
                  markers: Set.of((marker != null) ? [marker] : []),
                  circles: Set.of((circle != null) ? [circle] : []),
                  polylines: _polylines,
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                ),
              ),
              finishFlag == 1
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: getCurrentLocation,
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 25,
                          child: Text(
                            'Start',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 30,
                                fontWeight: FontWeight.w600),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue[100]),
                        ),
                      )),
              // FloatingActionButton(
              //   child: Icon(Icons.location_searching),
              //   onPressed: getCurrentLocation,
              // ),
              Row(
                children: [
                  Container(
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.directions_run,
                            color: Colors.black,
                          ),
                          Text(
                            '$dist',
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width / 7,
                                fontWeight: FontWeight.w700),
                          ),
                          Text('METRES')
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.grey[200], blurRadius: 5)
                        ],
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[200],
                      ),
                      margin: EdgeInsets.all(5),
                    ),
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 6,
                    //  color: Colors.white,
                  ),
                  Container(
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.speed,
                            color: Colors.black,
                          ),
                          Text(
                            '$speedString',
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width / 7,
                                fontWeight: FontWeight.w700),
                          ),
                          Text('KMPH')
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.grey[200], blurRadius: 5)
                        ],
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[200],
                      ),
                      margin: EdgeInsets.all(5),
                    ),
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 2,
                    //color: Colors.white,
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          var actions2 = [
                            FlatButton(
                              onPressed: () {
                                if (isChanged) {
                                  // storing final location
                                  storeFinalLat = finalLatitude;
                                  storeFinalLong = finalLongitude;
                                  endingTime = DateTime.now();
                                  passingToShowResults['initialLat'] =
                                      storeInitialLat;
                                  passingToShowResults['initialLong'] =
                                      storeInitialLong;
                                  passingToShowResults['finalLat'] =
                                      storeFinalLat;
                                  passingToShowResults['finalLong'] =
                                      storeFinalLong;
                                  passingToShowResults['initialTime'] =
                                      startingTime;
                                  passingToShowResults['finalTime'] =
                                      endingTime;
                                  passingToShowResults['distance'] = distance;
                                  passingToShowResults['listOfLatLng'] =
                                      listOfLatLngForPoly;

                                  print("All parameters stored successfully");
                                  // updatePolyLines(
                                  //   initialLatitude,
                                  //   initialLongitude,
                                  //   finalLatitude,
                                  //   finalLongitude,
                                  // );

                                  _locationSubscription.cancel();
                                  Navigator.of(context).pushReplacementNamed(
                                      ShowResultsScreen.routeName,
                                      arguments: passingToShowResults);
                                }
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
                            title: Text('Are you sure you want to end Run?'),
                            actions: actions2,
                          );
                        },
                      );
                    },
                    child: finishFlag == 0
                        ? Container()
                        : Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 25,
                            child: Text(
                              'Finish',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 30,
                                  fontWeight: FontWeight.w600),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red[200]),
                          ),
                  )),
              // Positioned(
              //     child: ListTile(
              //   tileColor: Color.fromRGBO(0, 0, 100, 1),
              //   leading: Icon(Icons.panorama_fish_eye_sharp),
              //   title: Text(
              //     "Distance - $dist metres",
              //     style: TextStyle(color: Colors.white, fontSize: 25),
              //   ),
              //   subtitle: Text(
              //     "Speed - $speedString m/s",
              //     style: TextStyle(color: Colors.white, fontSize: 25),
              //   ),
              // )),
              // Positioned(
              //   bottom: 19,
              //   left: 10,
              //   child: FloatingActionButton(
              //     heroTag: "2",
              //     backgroundColor: Colors.red,
              //     child: Icon(Icons.cancel),
              //     onPressed: () {
              //       showDialog(
              //         context: context,
              //         builder: (ctx) {
              //           var actions2 = [
              //             FlatButton(
              //               onPressed: () {
              //                 if (isChanged) {
              //                   // storing final location
              //                   storeFinalLat = finalLatitude;
              //                   storeFinalLong = finalLongitude;
              //                   endingTime = DateTime.now();
              //                   passingToShowResults['initialLat'] =
              //                       storeInitialLat;
              //                   passingToShowResults['initialLong'] =
              //                       storeInitialLong;
              //                   passingToShowResults['finalLat'] =
              //                       storeFinalLat;
              //                   passingToShowResults['finalLong'] =
              //                       storeFinalLong;
              //                   passingToShowResults['initialTime'] =
              //                       startingTime;
              //                   passingToShowResults['finalTime'] = endingTime;
              //                   passingToShowResults['distance'] = distance;
              //                   passingToShowResults['listOfLatLng'] =
              //                       listOfLatLngForPoly;

              //                   print("All parameters stored successfully");
              //                   // updatePolyLines(
              //                   //   initialLatitude,
              //                   //   initialLongitude,
              //                   //   finalLatitude,
              //                   //   finalLongitude,
              //                   // );

              //                   _locationSubscription.cancel();
              //                   Navigator.of(context).pushReplacementNamed(
              //                       ShowResultsScreen.routeName,
              //                       arguments: passingToShowResults);
              //                 }
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
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
