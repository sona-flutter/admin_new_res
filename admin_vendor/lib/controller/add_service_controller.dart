import 'dart:io';

import 'package:admin_vendor/controller/get_user_data_model.dart';
import 'package:admin_vendor/view/widgets/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddServiceController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker picker = ImagePicker();
  Rx<File?> imageFile = Rx<File?>(null);
  RxBool isAddProduct = false.obs;

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> addService(
    BuildContext context, {
    required String serviceName,
    required String description,
    required String price,
    required String discount,
    required String finalPrice,
    required String requiredTime,
    required String category,
  }) async {
    isAddProduct.value = true;
    Get.put(GetUserDataController());
    final GetUserDataController find = Get.find();

    try {
      String? imageUrl = await _uploadImage(context);

      await firestore.collection('Vendor').doc(find.userData!.uid!).update({
        'services': FieldValue.arrayUnion([
          {
            'services': serviceName,
            'description': description,
            'originalPrice': double.parse(price),
            'discount': double.parse(discount),
            'finalPrice': double.parse(finalPrice),
            'imageUrl': imageUrl,
            'createdAt': Timestamp.now(),
            'rating': null,
            'isAvailableService': true,
            'requiredTime': requiredTime,
            'category': category,
          }
        ])
      });
      CustomSnackbar.customSnackbar(
          isError: false, message: 'Service added successfully!');
    } catch (e) {
      CustomSnackbar.customSnackbar(
          isError: true, message: 'Failed to add Service: $e');
    } finally {
      isAddProduct.value = false;
    }

    update();
  }

  Future<String?> _uploadImage(BuildContext context) async {
    if (imageFile.value == null) return null;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('product_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      await ref.putFile(imageFile.value!);
      return await ref.getDownloadURL();
    } catch (e) {
      CustomSnackbar.customSnackbar(
          isError: true, message: 'Failed to upload image: $e');

      return null;
    }
  }
}
