// lib/view/transaction/widgets/transaction_summary.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/controller/transaction_controller.dart';
import 'package:my_shop_app/models/transaction.dart';

class TransactionSummary extends StatelessWidget {
  TransactionSummary({Key? key}) : super(key: key);

  final TransactionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Calculate summary statistics
      final totalTransactions = controller.transactions.length;
      final completedTransactions = controller.transactions
          .where((t) => t.status.toLowerCase() == 'completed')
          .length;
      final pendingTransactions = totalTransactions - completedTransactions;

      final totalAmount = controller.totalAmount;
      final avgTicketSize =
          totalTransactions > 0 ? totalAmount / totalTransactions : 0.0;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            childAspectRatio: 1.5,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildSummaryCard(
                title: 'Total Revenue',
                value: 'Rp ${totalAmount.toStringAsFixed(2)}',
                icon: Icons.account_balance_wallet,
                color: Colors.blue,
              ),
              _buildSummaryCard(
                title: 'Avg Ticket Size',
                value: 'Rp ${avgTicketSize.toStringAsFixed(2)}',
                icon: Icons.receipt_long,
                color: Colors.green,
              ),
              _buildSummaryCard(
                title: 'Completed',
                value: '$completedTransactions',
                icon: Icons.check_circle_outline,
                color: Colors.teal,
              ),
              _buildSummaryCard(
                title: 'Pending',
                value: '$pendingTransactions',
                icon: Icons.pending_actions,
                color: Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildChart(),
        ],
      );
    });
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    // Group transactions by payment method
    final paymentMethodStats = <String, int>{};
    for (var transaction in controller.transactions) {
      paymentMethodStats[transaction.paymentMethod] =
          (paymentMethodStats[transaction.paymentMethod] ?? 0) + 1;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Methods',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...paymentMethodStats.entries.map((entry) {
              final percentage =
                  (entry.value / controller.transactions.length) * 100;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key),
                        Text('${percentage.toStringAsFixed(1)}%'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: percentage / 100,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getPaymentMethodColor(entry.key),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Color _getPaymentMethodColor(String paymentMethod) {
    switch (paymentMethod.toLowerCase()) {
      case 'cash':
        return Colors.green;
      case 'qris':
        return Colors.blue;
      case 'credit/debit':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
