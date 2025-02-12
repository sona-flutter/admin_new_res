import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxString salonName = 'xyz'.obs;
  final RxString salonEmail = '@gmail.com'.obs;
  final RxString salonLocation = 'pune'.obs;
  final RxString salonHours = '9:00 AM - 9:00 PM'.obs;
  final RxString salonContact = '-'.obs;
  final RxInt totalStaff = 10.obs;
  final RxInt totalServices = 1.obs;
  final RxInt services = 0.obs;
  final RxInt totalChairs = 9.obs;
  final RxDouble rating = 3.8.obs;
  final RxString description =
      'Premium salon services with experienced staff.\nSpecializing in haircuts, styling, and beauty treatments.'
          .obs;

  // Move these lists inside the controller
  List<Map<String, dynamic>> get servicesList => [
        {'name': 'Haircut', 'price': 30, 'duration': '30 min'},
        {'name': 'Hair Color', 'price': 75, 'duration': '90 min'},
        {'name': 'Facial', 'price': 50, 'duration': '60 min'},
        {'name': 'Manicure', 'price': 25, 'duration': '45 min'},
      ];

  List<Map<String, dynamic>> get staffMembers => [
        {'name': 'John Doe', 'role': 'Senior Stylist', 'rating': 4.9},
        {'name': 'Jane Smith', 'role': 'Colorist', 'rating': 4.8},
        {'name': 'Mike Johnson', 'role': 'Barber', 'rating': 4.7},
        {'name': 'Sarah Williams', 'role': 'Nail Artist', 'rating': 4.9},
      ];
}
