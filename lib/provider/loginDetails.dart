import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDetails extends ChangeNotifier{


  User? _user;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  String? userEmail;
  String? userId;
  String? userName;
  String? userPassword;
  String? userType;

  void setUser(User user) {
    _user = user;
  }

  Future<void> setSharedPreferences() async {
    if (_user != null) {
      userEmail = _user!.email ?? '';
      userId = _user!.uid ?? '';
      userName = _user!.displayName ?? '';
      userPassword = ''; // assuming you're storing the password in a variable called 'password'
      userType = ''; // set the user type here

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userEmail', userEmail!);
      prefs.setString('userId', userId!);
      prefs.setString('userName', userName!);
      prefs.setString('userPassword', userPassword!);
      prefs.setString('userType', userType!);
    }
  }

  Future<void> getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('userEmail') ?? '';
    userId = prefs.getString('userId') ?? '';
    userName = prefs.getString('userName') ?? '';
    userPassword = prefs.getString('userPassword') ?? '';
    userType = prefs.getString('userType') ?? '';

    // Do something with the retrieved values here
  }
  Future userSignOut() async {

    _isSignedIn = false;
    notifyListeners();
    // clear all storage information
    clearStoredData();
  }

  Future clearStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }
}

