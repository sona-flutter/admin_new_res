// lib/controller/transaction_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/transaction_model.dart';

class TransactionController extends GetxController {
  var transactions = <Transaction>[].obs;
  var isLoading = false.obs;
  var selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 7)),
    end: DateTime.now(),
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  void fetchTransactions() {
    isLoading.value = true;
    // Simulate API call with dummy data
    Future.delayed(const Duration(seconds: 1), () {
      transactions.value = [
        Transaction(
          id: "#000056",
          orderType: "Dine In",
          amount: 55.0,
          paymentMethod: "QRIS",
          date: DateTime.now(),
          status: "Completed",
        ),
        Transaction(
          id: "#000055",
          orderType: "Take Away",
          amount: 80.0,
          paymentMethod: "Credit/Debit",
          date: DateTime.now(),
          status: "Pending",
        ),
        // Add more dummy transactions here
      ];
      isLoading.value = false;
    });
  }

  double get totalAmount => transactions.fold(
        0,
        (sum, transaction) => sum + transaction.amount,
      );

  void filterByDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
    fetchTransactions(); // In real app, you would filter based on date range
  }
}
