// lib/view/sidebar/order/order_screen.dart
import 'package:flutter/material.dart';
import 'package:my_shop_app/view/sidebar/order/widgets/order_model.dart';

import 'widgets/order_tab.dart';
import 'widgets/order_list_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String selectedTab = 'All orders';
  List<Order> orders = [];
  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();
    // Initialize with sample data
    _loadSampleData();
  }

  void _loadSampleData() {
    orders = [
      Order(
        id: '2632',
        name: 'Brooklyn Zoe',
        address: '302 Snider Street, RUTLAND, VT, 05701',
        date: '31 Jul 2020',
        price: 64.00,
        status: 'Pending',
        avatarUrl: 'https://via.placeholder.com/32',
      ),
      Order(
        id: '2633',
        name: 'John McCormick',
        address: '1095 Wiseman Street, CALMAR, IA, 52132',
        date: '01 Aug 2020',
        price: 35.00,
        status: 'Dispatch',
        avatarUrl: 'https://via.placeholder.com/32',
      ),
      Order(
        id: '2634',
        name: 'Sandra Pugh',
        address: '1640 Thorn Street, SALE CITY, GA, 98506',
        date: '02 Aug 2020',
        price: 74.00,
        status: 'Completed',
        avatarUrl: 'https://via.placeholder.com/32',
      ),
      Order(
        id: '2635',
        name: 'Vernie Hart',
        address: '3898 Oak Drive, DOVER, DE, 19904',
        date: '02 Aug 2020',
        price: 82.00,
        status: 'Pending',
        avatarUrl: 'https://via.placeholder.com/32',
      ),
      Order(
        id: '2636',
        name: 'Mark Clark',
        address: '1595 Augusta Park, NASSAU, NY, 12062',
        date: '03 Aug 2020',
        price: 39.00,
        status: 'Dispatch',
        avatarUrl: 'https://via.placeholder.com/32',
      ),
      Order(
        id: '2637',
        name: 'Rebekah Foster',
        address: '3485 Park Boulevard, BIOLA, CA, 93606',
        date: '03 Aug 2020',
        price: 67.00,
        status: 'Pending',
        avatarUrl: 'https://via.placeholder.com/32',
      ),
    ];
    setState(() {});
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? dateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialDateRange: selectedDateRange,
    );

    if (dateRange != null) {
      setState(() {
        selectedDateRange = dateRange;
      });
    }
  }

  void _onTabSelected(String tabName) {
    setState(() {
      selectedTab = tabName;
    });
    // Add filtering logic here
  }

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
              ),
            ),
            const SizedBox(height: 20),
            // Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  OrderTab(
                    text: 'All orders',
                    isSelected: selectedTab == 'All orders',
                    onTap: () => _onTabSelected('All orders'),
                  ),
                  OrderTab(
                    text: 'Dispatch',
                    isSelected: selectedTab == 'Dispatch',
                    onTap: () => _onTabSelected('Dispatch'),
                  ),
                  OrderTab(
                    text: 'Pending',
                    isSelected: selectedTab == 'Pending',
                    onTap: () => _onTabSelected('Pending'),
                  ),
                  OrderTab(
                    text: 'Completed',
                    isSelected: selectedTab == 'Completed',
                    onTap: () => _onTabSelected('Completed'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Date range and search
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _selectDateRange,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            selectedDateRange != null
                                ? '${selectedDateRange!.start.toString().split(' ')[0]} to ${selectedDateRange!.end.toString().split(' ')[0]}'
                                : 'Select date range',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Implement search functionality
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // List header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 25, 28, 31),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                children: [
                  Expanded(flex: 1, child: Text('Order ID')),
                  Expanded(flex: 2, child: Text('Name')),
                  Expanded(flex: 3, child: Text('Address')),
                  Expanded(flex: 1, child: Text('Date')),
                  Expanded(flex: 1, child: Text('Price')),
                  Expanded(flex: 1, child: Text('Status')),
                  Expanded(flex: 1, child: Text('Action')),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderListItem(
                    order: orders[index],
                    onSettingsTap: (order) {
                      // Implement settings action
                    },
                    onMoreTap: (order) {
                      // Implement more options action
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
