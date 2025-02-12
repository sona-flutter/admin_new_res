// lib/view/sidebar/services/components/service_card.dart
import 'package:admin_vendor/view/sidebar/services/components/models/service_model.dart';
import 'package:admin_vendor/view/sidebar/services/components/services_card.dart';
import 'package:admin_vendor/view/sidebar/services/components/stats_card.dart';

import 'package:flutter/material.dart';

import '../constants.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(ServicesConstants.getCategoryIcon(service.category)),
        ),
        title: Text(service.name),
        subtitle: Text('₹${service.price}'),
        trailing: Switch(
          value: service.isActive,
          onChanged: onStatusChanged,
        ),
      ),
    );
  }
}
