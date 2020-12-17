// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './RunModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RunDataProvider with ChangeNotifier {
  String _uid;

  // String _uid = ''; //geddam's UID: 6xjRKs7BI6TLvM6aekhyAUidPAc2
  // temporary change for dev purpose on next line. Revert after.
  // _uid = '6xjRKs7BI6TLvM6aekhyAUidPAc2';
  String _token;

  List<RunModel> _yourRunsList = [
    // RunModel(
    //   uid: 'gautam.pv@iitgn.ac.in',
    //   dateOfRun: 'Thu, Oct 22, 2020',
    //   avgSpeed: '8',
    //   distanceCovered: '2.8',
    //   startTime: '17:36',
    //   timeOfRunHrs: '00',
    //   timeOfRunMin: '24',
    //   timeOfRunSec: '23',
    //   listOfLatLng: [
    //     {'latitude': 2, 'longitude': 3}
    //   ],
    //   intialLatitude: 2,
    //   initialLongitude: 3,
    // ),
    // RunModel(
    //   uid: 'gautam.pv@iitgn.ac.in',
    //   dateOfRun: 'Thu, Oct 22, 2020',
    //   avgSpeed: '6.8',
    //   distanceCovered: '3.8',
    //   startTime: '18:33',
    //   timeOfRunHrs: '00',
    //   timeOfRunMin: '29',
    //   timeOfRunSec: '33',
    //   listOfLatLng: [
    //     {'latitude': 2, 'longitude': 3}
    //   ],
    //   initialLongitude: 3,
    //   intialLatitude: 2,
    // ),
  ];

//  var x =  _yourRunsList[0];

  void setToken(String token) {
    _token = token;
  }

  void setUid(String userUid) {
    _uid = userUid;
    // print('uid has been set');
    notifyListeners();
    // print("uid is $_uid");
  }

  Future<void> getRunStatsFromDb() async {
    final url =
        'https://authentications-c0299.firebaseio.com/RunData.json?auth=$_token&orderBy="uid"&equalTo="$_uid"';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<RunModel> loadedList = [];
      // print(extractedData['-MMvLcgO2K3wHZkueZcV']['listOfLatLng'].runtimeType);
      extractedData.forEach((statId, statVal) {
        loadedList.add(
          new RunModel(
            databaseID: statId,
            uid: statVal['uid'],
            dateOfRun: statVal['dateOfRun'],
            avgSpeed: statVal['avgSpeed'],
            distanceCovered: statVal['distanceCovered'],
            startTime: statVal['startTime'],
            timeOfRunSec: statVal['timeOfRunSec'],
            timeOfRunMin: statVal['timeOfRunMin'],
            timeOfRunHrs: statVal['timeOfRunHrs'],
            listOfLatLng: statVal['listOfLatLng'],
            initialLongitude: statVal['initialLongitude'],
            initialLatitude: statVal['initialLatitude'],
          ),
        );

        // print(loadedList[0].avgSpeed);
        // print(loadedList[0].databaseID);
        print(loadedList[0].dateOfRun);
        // print(loadedList[0].distanceCovered);
        // print(loadedList[0].initialLatitude);
        // print(loadedList[0].initialLongitude);

        _yourRunsList = loadedList;
        notifyListeners();
      });
      print("Loaded List is ready");
      print(json.decode(response.body));
    } catch (e) {
      throw (e);
    }
  }

  List<RunModel> get yourRunsList {
    return [..._yourRunsList];
  }

  Future<void> addNewRunData(
    // uid is already passed through the provider
    String dateOfRun,
    String avgSpeed,
    String distanceCovered,
    String startTime,
    String timeOfRunHrs,
    String timeOfRunMin,
    String timeOfRunSec,
    List<Map<String, double>> listOfLatLng,
    double initialLatitude,
    double initialLongitude,
  ) {
    print("The Uid Is " + _uid);
    final url =
        'https://authentications-c0299.firebaseio.com/RunData.json?auth=$_token';
    return http
        .post(
      url,
      body: json.encode(
        {
          'uid': _uid,
          'dateOfRun': dateOfRun,
          'avgSpeed': avgSpeed,
          'distanceCovered': distanceCovered,
          'startTime': startTime,
          'timeOfRunSec': timeOfRunSec,
          'timeOfRunMin': timeOfRunMin,
          'timeOfRunHrs': timeOfRunHrs,
          'listOfLatLng': listOfLatLng,
          'initialLatitude': initialLatitude,
          'initialLongitude': initialLongitude
        },
      ),
    )
        .then(
      (response) {
        var databaseId = json.decode(response.body)['name'];
        _yourRunsList.add(
          RunModel(
            databaseID: databaseId,
            uid: _uid,
            dateOfRun: dateOfRun,
            avgSpeed: avgSpeed,
            distanceCovered: distanceCovered,
            startTime: startTime,
            timeOfRunSec: timeOfRunSec,
            timeOfRunMin: timeOfRunMin,
            timeOfRunHrs: timeOfRunHrs,
            listOfLatLng: listOfLatLng,
            initialLatitude: initialLatitude,
            initialLongitude: initialLongitude,
          ),
        );
        notifyListeners();
      },
    ).catchError((error) {
      print(error);
      throw error;
    });
  }
}
