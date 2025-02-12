// profile_staff.dart
import 'package:admin_vendor/view/sidebar/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileStaff extends StatelessWidget {
  final ProfileController controller =
      Get.find<ProfileController>(); // Get the controller

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildStaffList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Staff Members',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('View All'),
        ),
      ],
    );
  }

  Widget _buildStaffList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.staffMembers.length,
      itemBuilder: (context, index) {
        final staff = controller.staffMembers[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(staff['name'][0]),
            ),
            title: Text(staff['name']),
            subtitle: Text(staff['role']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                Text('${staff['rating']}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
