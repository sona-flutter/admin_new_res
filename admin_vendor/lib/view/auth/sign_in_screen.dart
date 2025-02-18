import 'package:admin_vendor/controller/login_controller.dart';
import 'package:admin_vendor/services/auth_service.dart';
import 'package:admin_vendor/view/auth/forgot_password_screen.dart';
import 'package:admin_vendor/view/auth/sign_up_screen.dart';
import 'package:admin_vendor/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              const Text(
                'Log In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                controller: loginController.usernameController,
                hint: 'Username',
              ),
              const SizedBox(height: 15),
              Obx(
                () => _buildTextField(
                  controller: loginController.passwordController,
                  hint: 'Password',
                  isPassword: true,
                  obscureText: loginController.obscurePassword.value,
                  onToggleVisibility: () {
                    loginController.obscurePassword.value =
                        !loginController.obscurePassword.value;
                  },
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    fillColor: WidgetStateProperty.all(const Color(0xFFFF4C6F)),
                  ),
                  const Text(
                    'Remember me',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Get.to(() => ForgotPasswordScreen());
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: Color(0xFFFF4C6F)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                btnName: "Log In",
                onTap: () {
                  if (loginController.usernameController.text
                          .trim()
                          .isNotEmpty &&
                      loginController.passwordController.text
                          .trim()
                          .isNotEmpty) {
                    LoginUser.loginUser(
                      context,
                      email: loginController.usernameController.text,
                      password: loginController.passwordController.text,
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(
                        transition: Transition.fadeIn,
                        () => SignUpScreen(),
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Color(0xFFFF4C6F)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    FormFieldValidator<String>? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Updated radius to 10
        border: Border.all(color: const Color(0xFFFF4C6F)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? obscureText : false,
        style: const TextStyle(color: Colors.white),
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white54,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
        ),
      ),
    );
  }
}
