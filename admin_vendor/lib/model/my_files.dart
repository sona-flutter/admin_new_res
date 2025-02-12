// cloud_storage_info.dart
import 'package:admin_vendor/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? image, title, totalStorage;
  final int? percentage;
  final Color? color;

  CloudStorageInfo({
    this.image,
    this.title,
    this.totalStorage,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Services",
    image: "assets/icons/service.jpg",
    totalStorage: "5",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Orders",
    image: "assets/icons/service.jpg",
    totalStorage: "5",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Seats",
    image: "assets/icons/service.jpg",
    totalStorage: "3",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Staff",
    image: "assets/icons/service.jpg",
    totalStorage: "4",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
