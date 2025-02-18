import 'package:admin_vendor/services/forgot_password_service.dart';
import 'package:admin_vendor/view/widgets/custom_button.dart';
import 'package:admin_vendor/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 60),
            const Text(
              'Forgot Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 60),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFFF4C6F)),
              ),
              child: TextFormField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.white54),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              btnName: "Reset Password",
              onTap: () {
                // Add your password reset logic here
                if (emailController.text.trim().isNotEmpty) {
                  ForgotPassword.forgotPassword(
                    email: emailController.text,
                  );
                } else {
                  CustomSnackbar.customSnackbar(
                    isError: true,
                    message: "Please Enter Email",
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
