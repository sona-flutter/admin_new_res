import 'dart:developer';

import 'package:get/get.dart';

class ServiceModel {
  String description;
  num originalPrice;
  num discount;
  num finalPrice;
  RxBool isAvailableService;
  double rating;
  String service;
  String requiredTime;
  String? uploadTime;
  String category;

  ServiceModel({
    required this.description,
    required this.originalPrice,
    required this.discount,
    required this.finalPrice,
    required this.service,
    required this.rating,
    required this.isAvailableService,
    required this.requiredTime,
    required this.category,
  }) {
    log("SERVICE NAME $service");
  }
}
