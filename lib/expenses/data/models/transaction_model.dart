import 'package:expense_tracker/expenses/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.title,
    required super.amount,
    required super.date,
    required super.description,
    required super.category,
    required super.type,
  });
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
      'type': type,
    };
  }

  static TransactionModel fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      title: map['title'],
      description: map['description'],
      amount: double.parse(map['amount'].toString()),
      date: DateTime.parse(map['date']),
      category: map['category'], 
      type: map['type'],
    );
  }
}
