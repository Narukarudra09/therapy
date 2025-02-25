class TherapySession {
  final String id;
  final String date;
  final String title;
  final String status;
  final double amount;

  TherapySession({
    required this.id,
    required this.date,
    required this.title,
    required this.status,
    required this.amount,
  });

  factory TherapySession.fromMap(Map<String, dynamic> map) {
    return TherapySession(
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      title: map['title'] ?? false,
      status: map['status'] ?? '',
      amount: (map['amount'] ?? 0.0) as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'status': status,
      'amount': amount,
    };
  }
}
