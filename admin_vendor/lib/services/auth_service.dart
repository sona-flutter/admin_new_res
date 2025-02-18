import 'package:admin_vendor/controller/get_user_data_model.dart';
import 'package:admin_vendor/controller/signup_controller.dart';
import 'package:admin_vendor/main_screen.dart';
import 'package:admin_vendor/model/get_user_data_model.dart';
import 'package:admin_vendor/services/session_data.dart';
import 'package:admin_vendor/view/widgets/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class SignupNewUser {
  static Future<void> signUpNewUser(
    BuildContext context, {
    required String location,
    required int seats,
    required String email,
    required String password,
    required String lastName,
    required String phoneno,
    required String storeName,
    required String firstName,
    required String userName,
  }) async {
    final SignupController signupController = Get.put(SignupController());

    signupController.isSignUp.value = true;
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      CustomSnackbar.customSnackbar(
        isError: false,
        message: "Sign up successfully",
      );
      await firestore
          .collection('Vendor')
          .doc(
            userCredential.user!.uid,
          )
          .set({
        'first name': firstName,
        'last name': lastName,
        'phone number': phoneno,
        'email': email,
        'storeName': storeName,
        'location': location,
        'seats': seats,
        'password': password,
        'uid': userCredential.user!.uid,
        'services': [],
      });

      Get.back();
    } on FirebaseAuthException catch (e) {
      CustomSnackbar.customSnackbar(isError: true, message: e.message!);
    } finally {
      signupController.isSignUp.value = false;
    }
  }
}

class LoginUser {
  static void loginUser(BuildContext context,
      {required String email, required String password}) async {
    final SignupController signupController = Get.put(SignupController());
    final GetUserDataController getUserDataController =
        Get.put(GetUserDataController());

    signupController.isSignUp.value = true;

    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot data = await firestore
          .collection('Vendor')
          .doc(userCredential.user!.uid)
          .get();

      getUserDataController.userData =
          GetUserDataModel(data.data() as Map<String, dynamic>);

      CustomSnackbar.customSnackbar(
          isError: false, message: "Successfully Loged In");

      SessionData.setSessionData(setLogin: true);
      SessionData.setUid(setUid: userCredential.user!.uid);

      Get.offAll(() => const MainScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        CustomSnackbar.customSnackbar(
            isError: true, message: "Please check your Email Id & Password");
      } else {
        CustomSnackbar.customSnackbar(isError: true, message: e.message!);
      }
    } finally {
      signupController.isSignUp.value = false;
    }
  }
}
