import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String selectedTab = 'All orders';
  final TextEditingController _dateRangeController = TextEditingController();

  final List<Map<String, dynamic>> orders = [
    {
      'id': 'ORD001',
      'name': 'Emma Wilson',
      'service': 'Hair Coloring & Styling',
      'date': DateTime(2020, 7, 31),
      'price': 120.00,
      'status': 'Pending',
      'payment_status': 'Pending',
      'payment_method': '-'
    },
    {
      'id': 'ORD002',
      'name': 'Sarah Johnson',
      'service': 'Spa Facial Treatment',
      'date': DateTime(2020, 8, 1),
      'price': 85.00,
      'status': 'Dispatch',
      'payment_status': 'Paid',
      'payment_method': 'Cash'
    },
    {
      'id': 'ORD003',
      'name': 'Michael Brown',
      'service': 'Men\'s Haircut & Beard Trim',
      'date': DateTime(2020, 8, 2),
      'price': 45.00,
      'status': 'Completed',
      'payment_status': 'Paid',
      'payment_method': 'Card'
    },
    {
      'id': 'ORD004',
      'name': 'Lisa Anderson',
      'service': 'Manicure & Pedicure',
      'date': DateTime(2020, 8, 2),
      'price': 65.00,
      'status': 'Pending',
      'payment_status': 'Failed',
      'payment_method': 'Card'
    },
    {
      'id': 'ORD005',
      'name': 'James Miller',
      'service': 'Full Body Massage',
      'date': DateTime(2020, 8, 3),
      'price': 90.00,
      'status': 'Dispatch',
      'payment_status': 'Paid',
      'payment_method': 'UPI'
    },
    {
      'id': 'ORD006',
      'name': 'Jennifer Davis',
      'service': 'Hair Extensions',
      'date': DateTime(2020, 8, 3),
      'price': 200.00,
      'status': 'Pending',
      'payment_status': 'Pending',
      'payment_method': '-'
    },
    {
      'id': 'ORD007',
      'name': 'Robert Taylor',
      'service': 'Deep Conditioning Treatment',
      'date': DateTime(2020, 8, 4),
      'price': 55.00,
      'status': 'Completed',
      'payment_status': 'Paid',
      'payment_method': 'Cash'
    },
    {
      'id': 'ORD008',
      'name': 'Maria Garcia',
      'service': 'Bridal Makeup Package',
      'date': DateTime(2020, 8, 4),
      'price': 150.00,
      'status': 'Dispatch',
      'payment_status': 'Paid',
      'payment_method': 'Card'
    },
    {
      'id': 'ORD009',
      'name': 'David Martinez',
      'service': 'Hair Straightening',
      'date': DateTime(2020, 8, 5),
      'price': 110.00,
      'status': 'Pending',
      'payment_status': 'Failed',
      'payment_method': 'UPI'
    },
    {
      'id': 'ORD010',
      'name': 'Ashley White',
      'service': 'Waxing Service',
      'date': DateTime(2020, 8, 5),
      'price': 75.00,
      'status': 'Completed',
      'payment_status': 'Paid',
      'payment_method': 'Cash'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Orders',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTab('All orders'),
                  _buildTab('Dispatch'),
                  _buildTab('Pending'),
                  _buildTab('Completed'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dateRangeController,
              decoration: InputDecoration(
                hintText: 'Select date range',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                prefixIcon:
                    const Icon(Icons.calendar_today, color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minWidth: constraints.maxWidth),
                      child: DataTable(
                        headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        dataTextStyle: const TextStyle(color: Colors.white),
                        columns: const [
                          DataColumn(label: Text('Order ID')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Service')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Price')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Payment Status')),
                          DataColumn(label: Text('Payment Method')),
                        ],
                        rows: orders
                            .where((order) =>
                                selectedTab == 'All orders' ||
                                order['status'] == selectedTab)
                            .map((order) {
                          return DataRow(
                            cells: [
                              DataCell(Text(order['id'])),
                              DataCell(Text(order['name'])),
                              DataCell(Text(order['service'])),
                              DataCell(Text(
                                DateFormat('dd MMM yyyy').format(order['date']),
                              )),
                              DataCell(Text(
                                  '\$${order['price'].toStringAsFixed(2)}')),
                              DataCell(_buildStatusChip(order['status'])),
                              DataCell(_buildPaymentStatusChip(
                                  order['payment_status'])),
                              DataCell(_buildPaymentMethodChip(
                                  order['payment_method'])),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text) {
    final isSelected = selectedTab == text;
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedTab = text;
          });
        },
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.white.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Container(
                height: 2,
                width: 40,
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Colors.orange;
        break;
      case 'dispatch':
        backgroundColor = Colors.green;
        break;
      case 'completed':
        backgroundColor = Colors.blue;
        break;
      default:
        backgroundColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: backgroundColor),
      ),
      child: Text(
        status,
        style: TextStyle(color: backgroundColor),
      ),
    );
  }

  Widget _buildPaymentStatusChip(String status) {
    Color backgroundColor;
    switch (status.toLowerCase()) {
      case 'paid':
        backgroundColor = Colors.green;
        break;
      case 'pending':
        backgroundColor = Colors.orange;
        break;
      case 'failed':
        backgroundColor = Colors.red;
        break;
      default:
        backgroundColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: backgroundColor),
      ),
      child: Text(
        status,
        style: TextStyle(color: backgroundColor),
      ),
    );
  }

  Widget _buildPaymentMethodChip(String method) {
    Color backgroundColor;
    switch (method.toLowerCase()) {
      case 'cash':
        backgroundColor = Colors.green;
        break;
      case 'card':
        backgroundColor = Colors.blue;
        break;
      case 'upi':
        backgroundColor = Colors.purple;
        break;
      default:
        backgroundColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: backgroundColor),
      ),
      child: Text(
        method,
        style: TextStyle(color: backgroundColor),
      ),
    );
  }
}
