import 'package:expense_tracker/expenses/presentation/res/images.dart';
import 'package:flutter/material.dart';
import 'main_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(ImageAssets.intro, height: 131),
            const SizedBox(height: 11.0),
            const Text(
              'Expenz',
              style: TextStyle(
                fontSize: 56.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7F3DFF),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: kBottomNavigationBarHeight,
              ),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromHeight(56.0),
                  backgroundColor: const Color(0xFF7F3DFF),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
