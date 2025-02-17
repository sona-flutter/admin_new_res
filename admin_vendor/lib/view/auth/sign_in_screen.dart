import 'package:admin_vendor/view/auth/sign_in_screen.dart';
import 'package:admin_vendor/view/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1B2E),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 60),
              Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: firstNameController,
                      hint: 'First Name',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      controller: lastNameController,
                      hint: 'Last Name',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: emailController,
                hint: 'Email',
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: storeNameController,
                hint: 'Store Name',
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: seatsCountController,
                      hint: 'Seats Count',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      controller: locationController,
                      hint: 'Location',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: passwordController,
                hint: 'Password',
                isPassword: true,
                obscureText: obscurePassword,
                onToggleVisibility: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: confirmPasswordController,
                hint: 'Confirm Password',
                isPassword: true,
                obscureText: obscureConfirmPassword,
                onToggleVisibility: () {
                  setState(() {
                    obscureConfirmPassword = !obscureConfirmPassword;
                  });
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    fillColor: MaterialStateProperty.all(Color(0xFFFF4C6F)),
                  ),
                  Text(
                    'I Agree with ',
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'privacy',
                      style: TextStyle(color: Color(0xFFFF4C6F)),
                    ),
                  ),
                  Text(
                    ' and ',
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'policy',
                      style: TextStyle(color: Color(0xFFFF4C6F)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add your signup logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD94F04),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    },
                    child: Text(
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
        border: Border.all(color: Color(0xFFFF4C6F)),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? obscureText : false,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white54),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
