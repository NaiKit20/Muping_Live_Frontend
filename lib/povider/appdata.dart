import 'package:flutter/material.dart';

class UserProfile {
  int id = 0;
  String name = "";
  String email = "";
  int phone = 0;
  String address = "";
  int oid = 0;
}

class Appdata with ChangeNotifier {
  UserProfile _profile = UserProfile();
  UserProfile get profile => _profile;
  set profile(UserProfile profile) {
    _profile = profile;
  }
}