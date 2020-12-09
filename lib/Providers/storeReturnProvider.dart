// here, the storing of image

import 'dart:io';
import 'package:flutter/cupertino.dart';
import './UserInfoDataProvider.dart';

class StoreReturnProvider with ChangeNotifier {
  File _image;

//image has been made private property. can only be accessed by getImage and setImage
//Assign them the initial value based on database
  bool class_userInput_isSet = false;
  String _name = null;
  String _age = null;
  String _height = null;
  String _weight = null;
  String _gender = 'Select';
  String _diet = 'Select';
  String _workout = 'Select';

  void setUserInputBool(bool userInput_isSet) {
    userInput_isSet = class_userInput_isSet;
  }

//get Functions for other files to access these variables
  File getImage(String id) {
    return _image;
  }

  String getName(String id) {
    return _name;
  }

  String getAge(String id) {
    return _age;
  }

  String getHeight(String id) {
    return _height;
  }

  String getWeight(String id) {
    return _weight;
  }

  String getGender(String iid) {
    return _gender;
  }

  String getDiet(String id) {
    return _diet;
  }

  String getWorkout(String id) {
    return _workout;
  }

//set functions to set values of these variables
  void setImage({String id, File img}) {
    _image = img;
  }

  void setName({String id, String name}) {
    _name = name;
  }

  void setAge({String id, String age}) {
    _age = age;
  }

  void setHeight({String id, String height}) {
    _height = height;
    // print(_height);
  }

  void setWeight({String id, String weight}) {
    _weight = weight;
    // print(_weight);
  }

  void setGender({String id, String gender}) {
    _gender = gender;
    // print(_gender);
  }

  void setDiet({String id, String diet}) {
    _diet = diet;
    // print(_diet);
  }

  void setWorkout({String id, String workout}) {
    _workout = workout;
    // print(_workout);
  }

  void saveDetails(String id) {
    UserInfoProvider().addNewUserInfo(
        id, _name, _age, _height, _weight, _diet, _gender, _image);
    notifyListeners();
    print(" age is $_age");
    print("id is $id");
  }
}
