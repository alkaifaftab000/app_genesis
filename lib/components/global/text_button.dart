import 'package:flutter/material.dart';

class AppButton {
  Widget textButtonIcon(String title, IconData icon, VoidCallback? f) {
    return TextButton.icon(
        label: Text(
          title,
          style: TextStyle(color: Colors.grey.shade100),
        ),
        icon: Icon(
          icon,
          color: Colors.grey.shade100,
        ),
        onPressed: f,
        style: TextButton.styleFrom(
            backgroundColor: Colors.grey.shade800,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))));
  }
}
