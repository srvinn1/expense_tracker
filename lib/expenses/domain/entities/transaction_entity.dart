class TransactionEntity {
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final String category;
  final String type;

  TransactionEntity({
    required this.title,
    required this.amount,
    required this.date,
    required this.description,
    required this.category,
    required this.type,
  });
}
