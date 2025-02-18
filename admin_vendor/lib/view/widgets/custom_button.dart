import 'package:admin_vendor/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onTap;
  final SignupController signupController = Get.put(SignupController());

  CustomButton({super.key, required this.btnName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFD94F04), // Tiger Orange color
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Updated radius to 10
        ),
      ),
      child: Obx(
        () => signupController.isSignUp.value
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                btnName,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
