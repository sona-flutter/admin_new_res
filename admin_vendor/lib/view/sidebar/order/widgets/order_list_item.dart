// lib/view/sidebar/order/widgets/order_list_item.dart
import 'package:flutter/material.dart';
import 'package:my_shop_app/view/sidebar/order/widgets/order_model.dart';

class OrderListItem extends StatelessWidget {
  final Order order;
  final Function(Order) onSettingsTap;
  final Function(Order) onMoreTap;

  const OrderListItem({
    Key? key,
    required this.order,
    required this.onSettingsTap,
    required this.onMoreTap,
  }) : super(key: key);

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFFF9800); // Orange
      case 'dispatch':
        return const Color(0xFF4CAF50); // Green
      case 'completed':
        return const Color(0xFF2196F3); // Blue
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected =
        false; // You can make this dynamic based on selection state

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade50 : Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade50,
            offset: const Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            // Handle row tap
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    '#${order.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(order.avatarUrl),
                        radius: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        order.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    order.address,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    order.date,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '\$${order.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _getStatusColor(order.status).withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      order.status,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _getStatusColor(order.status),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          size: 20,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: () => onSettingsTap(order),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          size: 20,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: () => onMoreTap(order),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
