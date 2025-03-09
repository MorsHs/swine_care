import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartingSwineFarm extends StatelessWidget {
  const StartingSwineFarm({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.go('/guide/swine-farming');
      },
      child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 20, left: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xffef729e),
                        Color(0xffec7c86),
                        Color(0xffed896d)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.tips_and_updates_outlined),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Keeping Your Pigs Healthy",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                        const Text(
                          "Tips & Tricks for Swine Farming",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("assets/images/tips-and-tricks.png", height: 90, width: 100,),
              ],
            ),
          ]
      ),
    );
  }
}
