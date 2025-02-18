import 'package:admin_vendor/controller/get_service_controller.dart';
import 'package:admin_vendor/controller/get_user_data_model.dart';
import 'package:admin_vendor/view/sidebar/services/components/add_service_dialog.dart';
import 'package:admin_vendor/view/sidebar/services/components/services_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/stats_card.dart';
import 'constants.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String selectedCategory = 'All';
  TextEditingController searchController = TextEditingController();
  final GetServiceController getServiceController =
      Get.put(GetServiceController());
  final GetUserDataController userDataController =
      Get.put(GetUserDataController());

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
              salonName: userDataController.userData!.storeName!,
            ),
          );

          if (result != null) {
            return;
          }
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildOverviewCards() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Obx(
            () => StatsCard(
              title: 'Total Services',
              value: getServiceController.serviceList.length.toString(),
              color: const Color.fromARGB(
                  255, 80, 126, 159), // Light blue background
              icon: Icons.spa,
            ),
          ),
          Obx(
            () => StatsCard(
              title: 'Active Services',
              value: getServiceController.serviceList
                  .where((isAvailable) => isAvailable.isAvailableService.value)
                  .length
                  .toString(),
              color: const Color.fromARGB(
                  255, 79, 158, 86), // Light green background
              icon: Icons.check_circle,
            ),
          ),
          Obx(
            () => StatsCard(
              title: 'Inactive Services',
              value: getServiceController.serviceList
                  .where((s) => !s.isAvailableService.value)
                  .length
                  .toString(),
              color: const Color.fromARGB(
                  255, 146, 63, 75), // Light red background
              icon: Icons.remove_circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ServicesConstants.categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ChoiceChip(
              label: Text(ServicesConstants.categories[index]),
              selected: selectedCategory == ServicesConstants.categories[index],
              selectedColor: const Color.fromARGB(
                255,
                62,
                160,
                83,
              ), // Changed selected color
              onSelected: (selected) {
                setState(() {});
                selectedCategory = ServicesConstants.categories[index];
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search Services',
          prefixIcon: const Icon(Icons.search,
              color: Colors.purple), // Changed icon color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: Colors.purple), // Changed border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.purple), // Changed focused border color
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildServicesList() {
    var filteredServices = selectedCategory == 'All'
        ? getServiceController.serviceList
        : getServiceController.serviceList
            .where((s) => s.category == selectedCategory)
            .toList();

    return Obx(
      () => getServiceController.serviceList.isEmpty
          ? const Expanded(
              child: Center(
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category,
                    size: 80,
                  ),
                  Text("No Services Available"),
                ],
              ),
            ))
          : Expanded(
              child: ListView.builder(
                itemCount: filteredServices.length,
                itemBuilder: (context, index) {
                  return ServiceCard(
                    service: filteredServices[index],
                    onStatusChanged: (value) {
                      getServiceController.isAvailableServices(
                        index: index,
                        value: value,
                        filteredServices: filteredServices,
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
