import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';
import 'profile_details.dart';
import 'profile_services.dart';
import 'profile_staff.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileDetails(),
            const SizedBox(height: 16),
            ProfileServices(),
            const SizedBox(height: 16),
            ProfileStaff(),
          ],
        ),
      ),
    );
  }
}
