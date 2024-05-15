import 'package:expense_tracker/expenses/presentation/res/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MoneyInfoBox extends StatelessWidget {
  const MoneyInfoBox({super.key, required this.amount, this.isIncome = false});
  final int amount;
  final bool isIncome;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isIncome ? const Color(0xff00A86B) : const Color(0xffFD3C4A),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        child: Row(
          children: [
            SvgPicture.asset(
              isIncome ? IconAssets.income : IconAssets.expenses,
            ),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                text: isIncome ? 'Income\n' : 'Expenses\n',
                style: const TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: '\$$amount',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
