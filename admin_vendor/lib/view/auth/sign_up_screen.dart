import 'package:admin_vendor/controller/signup_controller.dart';
import 'package:admin_vendor/services/auth_service.dart';
import 'package:admin_vendor/view/widgets/custom_button.dart';
import 'package:admin_vendor/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final SignupController signupController = Get.find();

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
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: signupController.firstNameController,
                      hint: 'First Name',
                    ),
                  ),
                  Expanded(
                    child: _buildTextField(
                      controller: signupController.lastNameController,
                      hint: 'Last Name',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: signupController.userNameController,
                hint: 'Username',
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: signupController.emailController,
                hint: 'Email',
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: signupController.phonenoController,
                hint: 'Phone number',
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: signupController.storeNameController,
                hint: 'Store Name',
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: signupController.seatsCountController,
                      hint: 'Seats Count',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      controller: signupController.locationController,
                      hint: 'Location',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Obx(
                () => _buildTextField(
                  controller: signupController.passwordController,
                  hint: 'Password',
                  isPassword: true,
                  obscureText: signupController.obscurePassword.value,
                  onToggleVisibility: () {
                    signupController.obscurePassword.value =
                        !signupController.obscurePassword.value;
                  },
                ),
              ),
              const SizedBox(height: 15),
              Obx(
                () => _buildTextField(
                  controller: signupController.confirmPasswordController,
                  hint: 'Confirm Password',
                  isPassword: true,
                  obscureText: signupController.obscureConfirmPassword.value,
                  onToggleVisibility: () {
                    signupController.obscureConfirmPassword.value =
                        !signupController.obscureConfirmPassword.value;
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
                    'I Agree with ',
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'privacy',
                      style: TextStyle(color: Color(0xFFFF4C6F)),
                    ),
                  ),
                  const Text(
                    ' and ',
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'policy',
                      style: TextStyle(color: Color(0xFFFF4C6F)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                  btnName: "Sign up",
                  onTap: () {
                    if (signupController.emailController.text
                            .trim()
                            .isNotEmpty &&
                        signupController.passwordController.text
                            .trim()
                            .isNotEmpty &&
                        signupController.confirmPasswordController.text
                            .trim()
                            .isNotEmpty &&
                        signupController.firstNameController.text
                            .trim()
                            .isNotEmpty &&
                        signupController.phonenoController.text
                            .trim()
                            .isNotEmpty &&
                        signupController.locationController.text
                            .trim()
                            .isNotEmpty &&
                        signupController.seatsCountController.text
                            .trim()
                            .isNotEmpty &&
                        signupController.lastNameController.text
                            .trim()
                            .isNotEmpty &&
                        signupController.userNameController.text
                            .trim()
                            .isNotEmpty &&
                        signupController.storeNameController.text
                            .trim()
                            .isNotEmpty) {
                      if (signupController.passwordController.text ==
                          signupController.confirmPasswordController.text) {
                        SignupNewUser.signUpNewUser(
                          context,
                          firstName: signupController.firstNameController.text,
                          lastName: signupController.lastNameController.text,
                          userName: signupController.userNameController.text,
                          email: signupController.emailController.text,
                          phoneno: signupController.phonenoController.text,
                          storeName: signupController.storeNameController.text,
                          location: signupController.locationController.text,
                          seats: int.parse(
                              signupController.seatsCountController.text),
                          password: signupController.passwordController.text,
                        );
                      } else {
                        CustomSnackbar.customSnackbar(
                            isError: true, message: "Password does't match");
                      }
                    } else {
                      CustomSnackbar.customSnackbar(
                          isError: true, message: "Please Enter Values");
                    }
                  }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Sign in',
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
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFF4C6F)),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? obscureText : false,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
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
