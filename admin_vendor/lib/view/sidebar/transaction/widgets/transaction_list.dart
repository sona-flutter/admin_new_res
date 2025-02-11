// lib/view/transaction/widgets/transaction_list.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/controller/transaction_controller.dart';

import 'transaction_card.dart';

class TransactionList extends StatelessWidget {
  TransactionList({Key? key}) : super(key: key);

  final TransactionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.transactions.isEmpty) {
        return const Center(
          child: Text('No transactions found'),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.transactions.length,
        itemBuilder: (context, index) {
          final transaction = controller.transactions[index];
          return TransactionCard(transaction: transaction);
        },
      );
    });
  }
}
