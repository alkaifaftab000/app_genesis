import 'dart:async';
import 'package:app_genesis/view/TeacherPanel/teacher.dart';
import 'package:app_genesis/view/auth/new_login.dart';
import 'package:flutter/material.dart';

class SplashViewServices {
  void isCurrentUserLoggedIn(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
    });
  }
}