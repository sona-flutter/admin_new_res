// service_dialog.dart
import 'package:admin_vendor/controller/add_service_controller.dart';
import 'package:admin_vendor/controller/get_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddServiceDialog extends StatefulWidget {
  final String salonName;

  const AddServiceDialog({
    Key? key,
    required this.salonName,
  }) : super(key: key);

  @override
  State createState() => _AddServiceDialogState();
}

class _AddServiceDialogState extends State<AddServiceDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _serviceNameController;
  late TextEditingController _priceController;
  late TextEditingController _discountController;
  late TextEditingController _finalPriceController;
  late TextEditingController _descriptionController;
  late TextEditingController _requiredTime;
  final AddServiceController addServiceController =
      Get.put(AddServiceController());
  final GetServiceController getServiceController = GetServiceController();

  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _serviceNameController = TextEditingController();
    _priceController = TextEditingController();
    _discountController = TextEditingController();
    _descriptionController = TextEditingController();
    _requiredTime = TextEditingController();
    _finalPriceController = TextEditingController();
    _categoryController = TextEditingController();
  }

  @override
  void dispose() {
    _serviceNameController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _finalPriceController.dispose();
    _descriptionController.dispose();
    _requiredTime.dispose();
    super.dispose();
  }

  void _calculateFinalPrice() {
    if (_priceController.text.isNotEmpty &&
        _discountController.text.isNotEmpty) {
      double price = double.tryParse(_priceController.text) ?? 0;
      double discount = double.tryParse(_discountController.text) ?? 0;

      double finalPrice = price - (price * discount / 100);
      _finalPriceController.text = finalPrice.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width < 850
            ? MediaQuery.of(context).size.width * 0.9
            : MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        'Add New Service',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 40), // For balance
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Salon Name: ${widget.salonName}',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _serviceNameController,
                    label: 'Service Name',
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter service name'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _categoryController,
                    label: 'Category',
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter category' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter description'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _requiredTime,
                    label: 'Required time',
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter required time'
                        : null,
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    controller: _priceController,
                    label: 'Price',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter price' : null,
                    onChanged: (value) => _calculateFinalPrice(),
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    controller: _discountController,
                    label: 'Discount (%)',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return null;
                      double? discount = double.tryParse(value!);
                      if (discount == null || discount < 0 || discount > 100) {
                        return 'Enter valid discount (0-100)%';
                      }
                      return null;
                    },
                    onChanged: (value) => _calculateFinalPrice(),
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    controller: _finalPriceController,
                    label: 'Final Price',
                    enabled: false,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Get.back();
                          addServiceController.addService(
                            context,
                            serviceName: _serviceNameController.text,
                            description: _descriptionController.text,
                            price: _priceController.text,
                            discount: _discountController.text,
                            finalPrice: _finalPriceController.text,
                            requiredTime: _requiredTime.text,
                            category: _categoryController.text,
                          );
                          getServiceController.getProductData();
                        }
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Add Service',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool enabled = true,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white30),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white30),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}

// Usage example:
/*

*/
