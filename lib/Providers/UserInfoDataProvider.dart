import 'package:flutter/material.dart';
import './UserInfoModel.dart';
import 'dart:io';

class UserInfoProvider with ChangeNotifier {
  String _uid;
  List<UserInfoModel> _userInfoList = [
    UserInfoModel(
      uid: 'gautam.pv',
      name: 'Gautam',
      age: '19',
      diet: 'Vegetarian',
      gender: 'male',
      height: '181',
      weight: '75',
    ),
  ];

  List<UserInfoModel> get userInfoList {
    return [..._userInfoList];
  }

  void setUid(String userUid) {
    _uid = userUid;
    // print('uid has been set');
    notifyListeners();
    // print("uid is $_uid");
  }

  void addNewUserInfo(String uid, String name, String age, String height,
      String weight, String diet, String gender, File profilePhoto) {
    _userInfoList.add(
      UserInfoModel(
          uid: _uid,
          name: name,
          age: age,
          diet: diet,
          gender: gender,
          height: height,
          weight: weight,
          profilePhoto: profilePhoto),
    );
    print(_userInfoList);
    notifyListeners();
  }
}
