// lib/view/transaction/screens/transaction_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/view/sidebar/transaction/widgets/transaction_list.dart';
import 'package:my_shop_app/view/sidebar/transaction/widgets/transaction_summary.dart';
import '../../../controller/transaction_controller.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({Key? key}) : super(key: key);

  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildDateFilter(context),
              const SizedBox(height: 20),
              TransactionSummary(),
              const SizedBox(height: 20),
              TransactionList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Transactions',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => controller.fetchTransactions(),
        ),
      ],
    );
  }

  Widget _buildDateFilter(BuildContext context) {
    return Obx(() => Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8),
                Text(
                  '${controller.selectedDateRange.value.start.toString().split(' ')[0]} - '
                  '${controller.selectedDateRange.value.end.toString().split(' ')[0]}',
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    final DateTimeRange? newRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                      initialDateRange: controller.selectedDateRange.value,
                    );
                    if (newRange != null) {
                      controller.filterByDateRange(newRange);
                    }
                  },
                  child: const Text('Change Date'),
                ),
              ],
            ),
          ),
        ));
  }
}
