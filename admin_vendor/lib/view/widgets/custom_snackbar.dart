import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static customSnackbar({
    required bool isError,
    required String message,
  }) {
    Get.snackbar(
      isError ? "Error" : "Success", // Title
      message, // Message
      snackPosition: SnackPosition.BOTTOM, // Position of snackbar
      backgroundColor: isError ? Colors.red : Colors.green, // Background color
      colorText: Colors.white, // Text color
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3), // Auto dismiss after 3 seconds
      icon: Icon(
        isError ? Icons.error : Icons.check_circle,
        color: Colors.white,
      ),
    );
  }
}
