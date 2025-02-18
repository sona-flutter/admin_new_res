import 'dart:developer';

import 'package:admin_vendor/controller/get_user_data_model.dart';
import 'package:admin_vendor/model/service_model.dart';
import 'package:admin_vendor/view/widgets/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class GetServiceController extends GetxController {
  RxList serviceList = <ServiceModel>[].obs;
  RxBool isGettingService = false.obs;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  RxBool? isAvailableService;

  @override
  void onInit() {
    super.onInit();
    getProductData();
  }

  void getProductData() async {
    log("IN GET PRODUCT");
    isGettingService.value = true;
    GetUserDataController getUserDataController =
        Get.put(GetUserDataController());

    serviceList.clear();

    DocumentSnapshot<Map<String, dynamic>> response = await firebaseFirestore
        .collection('Vendor')
        .doc(getUserDataController.userData!.uid!)
        .get();

    Map<String, dynamic> responsedata = response.data() as Map<String, dynamic>;

    if (responsedata['services'].isNotEmpty) {
      for (int i = 0; i < await responsedata['services'].length; i++) {
        log("RESPONCE DATA ${responsedata['services'][i]}");
        serviceList.add(
          ServiceModel(
            requiredTime: responsedata['services'][i]['requiredTime'],
            isAvailableService:
                (responsedata['services'][i]['isAvailableService'] as bool).obs,
            description: responsedata['services'][i]['description'],
            discount: responsedata['services'][i]['discount'],
            finalPrice: responsedata['services'][i]['finalPrice'],
            originalPrice: responsedata['services'][i]['originalPrice'],
            service: responsedata['services'][i]['services'],
            rating: responsedata['services'][i]['rating'] ?? 0.0,
            category: responsedata['services'][i]['category'],
          ),
        );
      }
    }
    isGettingService.value = false;
    update();
  }

  void deletProduct(BuildContext context, {required int index}) async {
    Get.put(GetUserDataController());
    final GetUserDataController find = Get.find();
    try {
      final DocumentReference userDoc =
          firebaseFirestore.collection('Vendor').doc(find.userData!.uid);

      // Fetch the current product list
      final DocumentSnapshot snapshot = await userDoc.get();
      if (snapshot.exists) {
        serviceList.value = snapshot.get('services') ?? [];

        // Validate the index
        if (index >= 0 && index < serviceList.length) {
          // Remove the item at the specified index
          serviceList.removeAt(index);

          // Update Firestore with the modified list
          await userDoc.update({'services': serviceList});
        }
      }
      getProductData();
      CustomSnackbar.customSnackbar(
          isError: false, message: "Service Deleted Successfully");
    } catch (e) {
      CustomSnackbar.customSnackbar(isError: true, message: "$e");
      getProductData();
    }
    getProductData();
  }

  Future updateProduct(BuildContext context,
      {required int index,
      required Map<String, dynamic> updatedProduct}) async {
    Get.put(GetUserDataController());
    final GetUserDataController find = Get.find();

    // Reference to the Firestore document
    final documentRef =
        FirebaseFirestore.instance.collection('Vendor').doc(find.userData!.uid);

    try {
      // Fetch the current list of products
      DocumentSnapshot documentSnapshot = await documentRef.get();
      serviceList.value = documentSnapshot['services'];

      // Update the specific product
      serviceList[index] = updatedProduct;

      // Write the updated list back to Firestore
      await documentRef.update({'services': serviceList});

      CustomSnackbar.customSnackbar(
          isError: false, message: 'Product updated successfully!');
    } catch (e) {
      log("$e");
      CustomSnackbar.customSnackbar(isError: true, message: e.toString());
    }
    getProductData();
  }

  void isAvailableServices(
      {required int index,
      required bool value,
      required var filteredServices}) async {
    final GetUserDataController getUserDataController =
        Get.put(GetUserDataController());
    serviceList.indexWhere(
      (s) => s.isAvailableService == filteredServices[index].isAvailableService,
    );

    if (index != -1) {
      serviceList[index].isAvailableService.value = value;

      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        DocumentReference vendorDoc = firestore
            .collection("Vendor")
            .doc(getUserDataController.userData!.uid);

        // Fetch the current services array
        DocumentSnapshot snapshot = await vendorDoc.get();
        if (snapshot.exists && snapshot.data() != null) {
          List<dynamic> services = snapshot.get("services");

          if (index != -1) {
            services[index]["isAvailableService"] = value;

            // Update the Firestore document with the modified array
            await vendorDoc.update({"services": services});
            log("Service availability updated successfully!");
          } else {
            log("Service not found in the list!");
          }
        } else {
          log("Vendor document not found!");
        }
      } catch (e) {
        log("Error updating service availability: $e");
      }
    } else {
      log("Service not found in original list"); // Debugging log
    }
    update();
  }
}
