import 'package:flutter/foundation.dart';
import 'dart:io';

enum Diet {
  vegetarian,
  nonVegetarian,
  eggetarian,
  vegan,
}
enum Gender {
  male,
  female,
  other,
}

class UserInfoModel {
  String uid;
  String name;
  String age;
  String height;
  String weight;
  String gender;
  String diet;
  File profilePhoto = null;

  UserInfoModel({
    @required this.uid,
    @required this.name,
    @required this.age,
    @required this.diet,
    @required this.gender,
    @required this.height,
    this.profilePhoto,
    @required this.weight,
  });
}
