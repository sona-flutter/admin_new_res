import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isVisiblePassword = true.obs;
  RxBool isLogin = false.obs;
  RxBool obscurePassword = true.obs;
  RxBool isChecked = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void changePasswordVisibility() {
    isVisiblePassword.value = !isVisiblePassword.value;
    log("$isVisiblePassword");
  }
}
