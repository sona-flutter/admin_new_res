import 'package:flutter/material.dart';

class ServicesConstants {
  static const String title = "Services Management";

  static const List<String> categories = [
    'All',
    'Haircut',
    'Facial',
    'Massage',
    'Spa'
  ];

  static IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'haircut':
        return Icons.content_cut;
      case 'facial':
        return Icons.face;
      case 'massage':
        return Icons.spa;
      case 'spa':
        return Icons.hot_tub;
      default:
        return Icons.spa;
    }
  }
}
