// lib/view/transaction/widgets/transaction_card.dart

import 'package:flutter/material.dart';
import 'package:my_shop_app/model/transaction_model.dart';


class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: _buildLeadingIcon(),
        title: Text(transaction.orderType),
        subtitle: Text(transaction.paymentMethod),
        trailing: _buildTrailing(),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    IconData icon;
    Color color;

    switch (transaction.orderType.toLowerCase()) {
      case 'dine in':
        icon = Icons.restaurant;
        color = Colors.blue;
        break;
      case 'take away':
        icon = Icons.takeout_dining;
        color = Colors.green;
        break;
      case 'delivery':
        icon = Icons.delivery_dining;
        color = Colors.orange;
        break;
      default:
        icon = Icons.receipt;
        color = Colors.grey;
    }

    return CircleAvatar(
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, color: color),
    );
  }

  Widget _buildTrailing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Rp ${transaction.amount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: transaction.status.toLowerCase() == 'completed'
                ? Colors.green.withOpacity(0.1)
                : Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            transaction.status,
            style: TextStyle(
              color: transaction.status.toLowerCase() == 'completed'
                  ? Colors.green
                  : Colors.orange,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}