import 'dart:convert';

import 'package:app_genesis/utils/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class ApiController {
  Future<bool> addQuestion(dynamic data, BuildContext context) async {
    const String url = 'https://aravind10.pythonanywhere.com/Questions/create/';
    try {
      var ls = jsonEncode(data);
      // print('print $ls');
      final response = await http.post(Uri.parse(url), body: ls, headers: {
        'Content-Type':
            'application/json', // Set the content type to application/json
      });
      if (response.statusCode == 201) {
        if (context.mounted) {
          Utility.toastMessage('Question Added Succesfully', context,
              ToastificationType.success, ToastificationStyle.flatColored);
        }
        return true;
      } else {
        if (kDebugMode) {
          print('${response.statusCode}: failed');
          print(data);
        }
        if (context.mounted) {
          Utility.toastMessage(
              'Error Adding The Question ${response.statusCode}',
              context,
              ToastificationType.warning,
              ToastificationStyle.fillColored);
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Error Adding the Question : $e');
      }
      if (context.mounted) {
        Utility.toastMessage(e.toString(), context, ToastificationType.error,
            ToastificationStyle.fillColored);
      }
      return false;
    }
  }
}
