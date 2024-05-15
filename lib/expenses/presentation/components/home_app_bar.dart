import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFFD0B7ff),
      elevation: 0,
      title: const Row(
        children: [
          SizedBox(width: 8),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: Color(0xFFD0B7ff),
            ),
          ),
          SizedBox(width: 25),
          Text(
            'Welcome Camilla',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            size: 32,
            Icons.notifications_on_sharp,
            color: Color(0xFF7F3DFF),
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 16)
      ],
    );
  }
  
  @override
 
  Size get preferredSize => const Size.fromHeight(56.0);
}
