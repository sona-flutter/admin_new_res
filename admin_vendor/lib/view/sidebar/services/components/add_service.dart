// service_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddServiceDialog extends StatefulWidget {
  final String salonName;

  const AddServiceDialog({
    Key? key,
    required this.salonName,
  }) : super(key: key);

  @override
  _AddServiceDialogState createState() => _AddServiceDialogState();
}

class _AddServiceDialogState extends State<AddServiceDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _serviceNameController;
  late TextEditingController _priceController;
  late TextEditingController _discountController;
  late TextEditingController _finalPriceController;

  @override
  void initState() {
    super.initState();
    _serviceNameController = TextEditingController();
    _priceController = TextEditingController();
    _discountController = TextEditingController();
    _finalPriceController = TextEditingController();
  }

  @override
  void dispose() {
    _serviceNameController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _finalPriceController.dispose();
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
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Add New Service',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 40), // For balance
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Salon Name: ${widget.salonName}',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: _serviceNameController,
                    label: 'Service Name',
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter service name'
                        : null,
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: _priceController,
                    label: 'Price',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter price' : null,
                    onChanged: (value) => _calculateFinalPrice(),
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: _discountController,
                    label: 'Discount (%)',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return null;
                      double? discount = double.tryParse(value!);
                      if (discount == null || discount < 0 || discount > 100) {
                        return 'Enter valid discount (0-100)';
                      }
                      return null;
                    },
                    onChanged: (value) => _calculateFinalPrice(),
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: _finalPriceController,
                    label: 'Final Price',
                    enabled: false,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // TODO: Implement service addition logic
                          Navigator.pop(context, {
                            'serviceName': _serviceNameController.text,
                            'price': double.parse(_priceController.text),
                            'discount': double.parse(_discountController.text),
                            'finalPrice':
                                double.parse(_finalPriceController.text),
                          });
                        }
                      },
                      icon: Icon(Icons.add, color: Colors.white),
                      label: Text(
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
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white30),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white30),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
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
