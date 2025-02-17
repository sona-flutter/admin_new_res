import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileDetails extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileImage(),
            const SizedBox(height: 12),
            _buildSalonName(),
            const SizedBox(height: 12),
            _buildStats(), // 
            const SizedBox(height: 12),
            _buildContactInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Obx(() {
      return GestureDetector(
        onTap: () => controller.pickImage(),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[300],
          backgroundImage: controller.profileImage.value != null
              ? FileImage(File(controller.profileImage.value!)) as ImageProvider
              : const AssetImage('assets/default_avatar.png'),
          child: controller.profileImage.value == null
              ? const Icon(Icons.camera_alt, size: 28, color: Colors.white)
              : null,
        ),
      );
    });
  }

  Widget _buildSalonName() {
    return Obx(() => Text(
          controller.salonName.value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ));
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(
            Icons.people, '${controller.staffMembers.length}', 'Staff'),
        _verticalDivider(),
        _buildStatItem(
            Icons.build, '${controller.services.length}', 'Services'),
        _verticalDivider(),
        _buildStatItem(Icons.chair, '8', 'Chairs'),
        _verticalDivider(),
        _buildStatItem(Icons.star, '${controller.rating}', 'Rating'),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey.shade400,
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue.shade600, size: 24),
        const SizedBox(height: 2),
        Text(value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.teal.shade700,
            )),
        Text(label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blueGrey.shade600,
            )),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.email, size: 18, color: Colors.blueGrey.shade600),
          title: Obx(() => Text(
                controller.salonEmail.value,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              )),
        ),
        ListTile(
          leading: Icon(Icons.phone, size: 18, color: Colors.blueGrey.shade600),
          title: Obx(() => Text(
                controller.salonPhone.value,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              )),
        ),
        ListTile(
          leading: Icon(Icons.location_on,
              size: 18, color: Colors.blueGrey.shade600),
          title: Obx(() => Text(
                controller.salonAddress.value,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              )),
        ),
      ],
    );
  }
}
