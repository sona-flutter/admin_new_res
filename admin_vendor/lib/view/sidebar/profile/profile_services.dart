import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileServices extends GetView<ProfileController> {
  const ProfileServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildServicesList(), // Removed parameter
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Services',
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

  Widget _buildServicesList() {
    // Removed parameter
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.servicesList.length,
      itemBuilder: (context, index) {
        final service = controller.servicesList[index];
        return Card(
          child: ListTile(
            title: Text(service['name']),
            subtitle: Text(service['duration']),
            trailing: Text(
              '\$${service['price']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
        );
      },
    );
  }
}
