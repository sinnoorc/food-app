import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../modules/register/register.dart';

class Utils {
  static showInternetDialog() {
    if (Get.isDialogOpen!) Get.back();
    return Get.dialog(
      CupertinoAlertDialog(
        title: const Text('No Internet Connection'),
        content: const Text('Please check your internet connection'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Ok'),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  static showSnackbar({
    required String title,
    required String message,
    bool isError = true,
  }) {
    if (Get.isSnackbarOpen) Get.back();
    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      backgroundColor: isError ? Colors.red : null,
      colorText: isError ? Colors.white : null,
      icon: isError ? const Icon(Icons.error_outline, color: Colors.white) : null,
    );
  }

  
}
