import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  // New controllers for additional fields
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController seatsCountController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phonenoController = TextEditingController();

  RxBool isSignUp = false.obs;
}
