import 'package:admin_vendor/view/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForgotPassword {
  static void forgotPassword({required String email}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      CustomSnackbar.customSnackbar(
          isError: false, message: "Password reset link sent to your email");
      Get.back();
    } on FirebaseAuthException catch (e) {
      CustomSnackbar.customSnackbar(isError: true, message: e.message!);
    } catch (e) {
      CustomSnackbar.customSnackbar(isError: true, message: "$e");
    }
  }
}
