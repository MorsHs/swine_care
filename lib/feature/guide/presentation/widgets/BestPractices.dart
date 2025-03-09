import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BestPractices extends StatelessWidget {
  const BestPractices({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.go('/guide/best-practices');
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
                        Color(0xff6baed7),
                        Color(0xff7cdfec),
                        Color(0xff6da4ed)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.star_border_outlined),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Managing Your Swine Farm",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                        const Text(
                          "Best Practices for Success",
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
                Image.asset("assets/images/best.png", height: 90, width: 100,),
              ],
            ),
          ]
      ),
    );
  }
}
