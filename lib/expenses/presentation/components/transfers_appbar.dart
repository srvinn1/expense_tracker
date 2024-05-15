import 'package:flutter/material.dart';

class TransfersAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TransfersAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Row(
        children: [
          Text(
            'See your financial report',
            style: TextStyle(
              color: Color(0xFF7F3DFF),
            ),
          ),
        ],
      ),
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
