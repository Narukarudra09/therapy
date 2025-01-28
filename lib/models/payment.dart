class Payment {
  final String id;
  final String date;
  final double amount;
  final bool isDebit;
  final String description;

  Payment({
    required this.id,
    required this.date,
    required this.amount,
    required this.isDebit,
    required this.description,
  });
}
