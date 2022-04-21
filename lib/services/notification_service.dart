import 'package:flutter/material.dart';

class NotificationService {
  static late GlobalKey<ScaffoldMessengerState> messenger = GlobalKey();
  static showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    messenger.currentState!.showSnackBar(snackBar);
  }
}
