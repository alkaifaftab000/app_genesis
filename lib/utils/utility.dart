import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Utility {
  static ToastificationItem toastMessage(String message, BuildContext context,
      ToastificationType type, ToastificationStyle style) {
    return toastification.show(
      alignment: Alignment.bottomCenter,
      context: context, // optional if you use ToastificationWrapper
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
      type: type,
      style: style,
    );
  }

  static ToastificationItem toastMessageSuccess(String message, BuildContext context) {
    return toastification.show(
      alignment: Alignment.bottomCenter,
      context: context, // optional if you use ToastificationWrapper
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
      type: ToastificationType.success,
      style: ToastificationStyle.simple,
    );
  }

  static ToastificationItem toastMessageFail(String message, BuildContext context) {
    return toastification.show(
      alignment: Alignment.bottomCenter,
      context: context, // optional if you use ToastificationWrapper
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
      type: ToastificationType.error,
      style: ToastificationStyle.simple,
    );
  }
}
