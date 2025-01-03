import 'package:flutter/material.dart';
import 'package:swine_care/Route/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      routerConfig: RouterConfiguration().routes(),
    );
  }
}
