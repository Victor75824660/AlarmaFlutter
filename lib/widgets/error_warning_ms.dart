import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/colors/app_colors.dart';
import 'package:get/get.dart';

class Message {
  static void taskErrorOrWarning(String taskname, String taskErrorOrWarning) {
    Get.snackbar(
      taskname,
      taskErrorOrWarning,
      backgroundColor: AppColors.mainColor,
      titleText: Text(
        taskname,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      messageText: Text(
        taskErrorOrWarning,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.yellowAccent),
      ),
    );
  }
}
