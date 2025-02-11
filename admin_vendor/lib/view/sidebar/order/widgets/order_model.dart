// lib/models/order_model.dart

class Order {
  final String id;
  final String name;
  final String address;
  final String date;
  final double price;
  final String status;
  final String avatarUrl;

  Order({
    required this.id,
    required this.name,
    required this.address,
    required this.date,
    required this.price,
    required this.status,
    required this.avatarUrl,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      date: json['date'],
      price: double.parse(json['price'].toString()),
      status: json['status'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'date': date,
      'price': price,
      'status': status,
      'avatarUrl': avatarUrl,
    };
  }
}
