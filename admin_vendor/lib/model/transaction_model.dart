// lib/model/transaction_model.dart

class Transaction {
  final String id;
  final String orderType;
  final double amount;
  final String paymentMethod;
  final DateTime date;
  final String status;

  Transaction({
    required this.id,
    required this.orderType,
    required this.amount,
    required this.paymentMethod,
    required this.date,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? '',
      orderType: json['orderType'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      paymentMethod: json['paymentMethod'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderType': orderType,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'date': date.toIso8601String(),
      'status': status,
    };
  }
}
