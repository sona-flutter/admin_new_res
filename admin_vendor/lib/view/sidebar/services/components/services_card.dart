// lib/view/sidebar/services/components/service_card.dart
import 'package:admin_vendor/model/service_model.dart';
import 'package:admin_vendor/view/sidebar/services/constants.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final Function(bool) onStatusChanged;

  const ServiceCard({
    Key? key,
    required this.service,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(ServicesConstants.getCategoryIcon(service.category)),
        ),
        title: Text(service.service),
        subtitle: Text('₹${service.finalPrice}'),
        trailing: Obx(
          () => Switch(
            value: service.isAvailableService.value,
            onChanged: onStatusChanged,
          ),
        ),
      ),
    );
  }
}
