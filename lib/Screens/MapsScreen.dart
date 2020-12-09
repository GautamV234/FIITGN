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

  // void updatePolyLines(double initialLat, double initialLong, double finalLat,
  //     double finalLong) async {
  //   List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
  //     apiKey,
  //     initialLat,
  //     initialLong,
  //     finalLat,
  //     finalLong,
  //   );
  //   if (result.isNotEmpty) {
  //     // loop through all PointLatLng points and convert them
  //     // to a list of LatLng, required by the Polyline
  //     result.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //   }
  //   setState(() {
  //     // create a Polyline instance
  //     // with an id, an RGB color and the list of LatLng pairs
  //     Polyline polyline = Polyline(
  //         polylineId: PolylineId("poly"),
  //         color: Color.fromARGB(255, 40, 122, 198),
  //         points: polylineCoordinates);

  //     // add the constructed polyline as a set of points
  //     // to the polyline set, which will eventually
  //     // end up showing up on the map
  //     _polylines.add(polyline);
  //     print("This just ran");
  //   });
  // }

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
        listOfLatLngForPoly
            .add({'latitude': storeInitialLat, 'longitude': storeInitialLong});
        // listOfLatLngForPoly.add(LatLng(storeInitialLat, storeInitialLong));
        startingTime = DateTime.now();
        print("This portion is being run");
        flag = 1;
      }

      // print("Marker is updated");

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged().listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  bearing: 192.232,
                  tilt: 0,
                  zoom: 18.00)));
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

  @override
  void dispose() {
    if (_locationSubscription != null) {
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
        appBar: AppBar(
          title: Text('Track Your Run'),
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: initialPosition,
              mapType: MapType.normal,
              markers: Set.of((marker != null) ? [marker] : []),
              circles: Set.of((circle != null) ? [circle] : []),
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
            ),
            Positioned(
                child: ListTile(
              tileColor: Color.fromRGBO(0, 0, 100, 1),
              leading: Icon(Icons.panorama_fish_eye_sharp),
              title: Text(
                "Distance - $dist metres",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              subtitle: Text(
                "Speed - $speedString m/s",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            )),
            Positioned(
              bottom: 19,
              left: 10,
              child: FloatingActionButton(
                heroTag: "2",
                backgroundColor: Colors.red,
                child: Icon(Icons.cancel),
                onPressed: () {
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
                              passingToShowResults['finalLat'] = storeFinalLat;
                              passingToShowResults['finalLong'] =
                                  storeFinalLong;
                              passingToShowResults['initialTime'] =
                                  startingTime;
                              passingToShowResults['finalTime'] = endingTime;
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

                              Navigator.of(context).pushReplacementNamed(
                                  ShowResultsScreen.routeName,
                                  arguments: passingToShowResults);
                              _locationSubscription.cancel();
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
              ),
            ),
            Positioned(
                child: FloatingActionButton(
              child: Icon(Icons.location_searching),
              onPressed: getCurrentLocation,
            ))
          ],
        ),
      ),
    );
  }
}
