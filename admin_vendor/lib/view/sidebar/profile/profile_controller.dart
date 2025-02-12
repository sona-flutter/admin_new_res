import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final RxString salonName = ' Beauty Salon'.obs;
  final RxString salonEmail = 'contact@malasalon.com'.obs;
  final RxString salonPhone = '+1 234 567 890'.obs;
  final RxString salonAddress = '123 Main Street, City'.obs;
  final RxInt totalClients = 156.obs;
  final RxDouble rating = 4.8.obs;

  // Image path store karayla
  final RxnString profileImage = RxnString();

  // Image select function
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = pickedFile.path;
    }
  }

  // Services List
  List<Map<String, dynamic>> get services => [
        {'name': 'Haircut', 'price': 30, 'duration': '30 min'},
        {'name': 'Hair Color', 'price': 75, 'duration': '90 min'},
        {'name': 'Facial', 'price': 50, 'duration': '60 min'},
        {'name': 'Manicure', 'price': 25, 'duration': '45 min'},
      ];

  // Staff Members List
  List<Map<String, dynamic>> get staffMembers => [
        {'name': 'John Doe', 'role': 'Senior Stylist', 'rating': 4.9},
        {'name': 'Jane Smith', 'role': 'Colorist', 'rating': 4.8},
        {'name': 'Mike Johnson', 'role': 'Barber', 'rating': 4.7},
        {'name': 'Sarah Williams', 'role': 'Nail Artist', 'rating': 4.9},
      ];
}
