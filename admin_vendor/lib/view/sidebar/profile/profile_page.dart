import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/profile_controller.dart';
import 'profile_details.dart';
import 'profile_services.dart';
import 'profile_staff.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileDetails(),
            const SizedBox(height: 16),
            const ProfileServices(),
            const SizedBox(height: 16),
            const ProfileStaff(),
          ],
        ),
      ),
    );
  }
}
