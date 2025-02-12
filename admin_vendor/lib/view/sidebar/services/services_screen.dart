// lib/view/sidebar/services/services_screen.dart
import 'package:admin_vendor/view/sidebar/services/components/models/service_model.dart';
import 'package:admin_vendor/view/sidebar/services/components/services_card.dart';
import 'package:flutter/material.dart';

import 'components/add_service.dart';
import 'components/stats_card.dart';
import 'constants.dart';

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String selectedCategory = 'All';
  TextEditingController searchController = TextEditingController();

  // Updated sample data with more services
  List<ServiceModel> services = [
    // Haircuts
    ServiceModel(
        id: 'S001',
        name: 'Basic Haircut',
        category: 'Haircut',
        price: 200,
        isActive: true),
    ServiceModel(
        id: 'S002',
        name: 'Premium Haircut',
        category: 'Haircut',
        price: 400,
        isActive: true),
    ServiceModel(
        id: 'S003',
        name: 'Kids Haircut',
        category: 'Haircut',
        price: 150,
        isActive: false),

    // Facials
    ServiceModel(
        id: 'S004',
        name: 'Classic Facial',
        category: 'Facial',
        price: 500,
        isActive: true),
    ServiceModel(
        id: 'S005',
        name: 'Gold Facial',
        category: 'Facial',
        price: 1200,
        isActive: true),
    ServiceModel(
        id: 'S006',
        name: 'Diamond Facial',
        category: 'Facial',
        price: 2000,
        isActive: false),

    // Massage
    ServiceModel(
        id: 'S007',
        name: 'Full Body Massage',
        category: 'Massage',
        price: 1500,
        isActive: true),
    ServiceModel(
        id: 'S008',
        name: 'Head Massage',
        category: 'Massage',
        price: 300,
        isActive: true),
    ServiceModel(
        id: 'S009',
        name: 'Thai Massage',
        category: 'Massage',
        price: 2500,
        isActive: false),

    // Spa
    ServiceModel(
        id: 'S010',
        name: 'Aromatherapy',
        category: 'Spa',
        price: 3000,
        isActive: true),
    ServiceModel(
        id: 'S011',
        name: 'Body Scrub',
        category: 'Spa',
        price: 1800,
        isActive: true),
    ServiceModel(
        id: 'S012',
        name: 'Mud Bath',
        category: 'Spa',
        price: 2200,
        isActive: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildOverviewCards(),
          _buildCategoryFilter(),
          _buildSearchBar(),
          _buildServicesList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (context) => AddServiceDialog(
              salonName: "Apple",
            ),
          );

          if (result != null) {
            // Handle the result
            print(result);
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }

  Widget _buildOverviewCards() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          StatsCard(
            title: 'Total Services',
            value: services.length.toString(),
            color: Color.fromARGB(255, 80, 126, 159), // Light blue background
            icon: Icons.spa,
          ),
          StatsCard(
            title: 'Active Services',
            value: services.where((s) => s.isActive).length.toString(),
            color: Color.fromARGB(255, 79, 158, 86), // Light green background
            icon: Icons.check_circle,
          ),
          StatsCard(
            title: 'Inactive Services',
            value: services.where((s) => !s.isActive).length.toString(),
            color: Color.fromARGB(255, 146, 63, 75), // Light red background
            icon: Icons.remove_circle,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ServicesConstants.categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ChoiceChip(
              label: Text(ServicesConstants.categories[index]),
              selected: selectedCategory == ServicesConstants.categories[index],
              selectedColor: const Color.fromARGB(
                  255, 62, 160, 83), // Changed selected color
              onSelected: (selected) {
                setState(() {
                  selectedCategory = ServicesConstants.categories[index];
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search Services',
          prefixIcon:
              Icon(Icons.search, color: Colors.purple), // Changed icon color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Colors.purple), // Changed border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.purple), // Changed focused border color
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        onChanged: (value) {
          setState(() {
            // Search functionality
          });
        },
      ),
    );
  }

  Widget _buildServicesList() {
    var filteredServices = selectedCategory == 'All'
        ? services
        : services.where((s) => s.category == selectedCategory).toList();

    return Expanded(
      child: ListView.builder(
        itemCount: filteredServices.length,
        itemBuilder: (context, index) {
          return ServiceCard(
            service: filteredServices[index],
            onStatusChanged: (value) {
              setState(() {
                // Update service status logic
                services[services
                        .indexWhere((s) => s.id == filteredServices[index].id)]
                    .isActive = value;
              });
            },
          );
        },
      ),
    );
  }
}
