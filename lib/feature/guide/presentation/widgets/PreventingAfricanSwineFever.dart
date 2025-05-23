import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreventingAfricanSwineFever extends StatelessWidget {
  const PreventingAfricanSwineFever({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.go('/guide/preventing');
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
                        Color(0xff91ef72),
                        Color(0xff38ec87),
                        Color(0xff47b97f)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.shield_outlined),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Protecting Your Farm",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                        const Text(
                          "Preventing African Swine Fever",
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
                Image.asset("assets/images/insurance.png", height: 90, width: 100,),
              ],
            ),
          ]
      ),
    );
  }
}
