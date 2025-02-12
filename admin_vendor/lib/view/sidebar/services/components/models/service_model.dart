// lib/view/sidebar/services/models/service_model.dart
class ServiceModel {
  final String id;
  final String name;
  final String category;
  final double price;
  bool isActive;

  ServiceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.isActive,
  });
}
