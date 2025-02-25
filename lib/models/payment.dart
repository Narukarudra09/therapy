class Payment {
  String id;
  String date;
  double amount;
  bool isDebit;
  String description;

  Payment({
    required this.id,
    required this.date,
    required this.amount,
    required this.isDebit,
    required this.description,
  });

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      amount: (map['amount'] ?? 0.0) as double,
      isDebit: map['isDebit'] ?? false,
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'amount': amount,
      'isDebit': isDebit,
      'description': description,
    };
  }
}
