
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final String category;
  final String description;
  final bool isExpense;
  final double amount;
  final DateTime date;

  const TransactionCard({
    super.key,
    required this.category,
    required this.description,
    required this.isExpense,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
      child: Row(
        children: [
          Image.asset(
            'assets/images/${category.toLowerCase()}.png',
            height: 60,
            width: 60,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                description,
                style: const TextStyle(
                  color: Color(0xFF91919F),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              isExpense
                  ? Text(
                      '-\$${amount.toString()}',
                      style: const TextStyle(
                        color: Color(0xFFFD3C4A),
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Text(
                      '+\$${amount.toString()}',
                      style: const TextStyle(
                        color: Color(0xFF00A86B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              Text(
                date.toString().substring(0, 10),
                style: const TextStyle(
                  color: Color(0xFF91919F),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
