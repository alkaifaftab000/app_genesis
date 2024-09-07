import 'dart:async';
import 'package:app_genesis/view/app_info_view.dart';
import 'package:flutter/material.dart';

class SplashViewServices {
  void isCurrentUserLoggedIn(BuildContext context) {
    Timer.periodic((const Duration(seconds: 3)), (timer) async {
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AppInfoView()));
    });
  }
}
