import 'package:flutter/material.dart';
import 'package:swine_care/feature/homepage/presentation/widget/homesswidget/PrimaryHeaderContainer.dart';

class Homess extends StatelessWidget {
  const Homess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //header
            PrimaryHeaderContainer(
                child: Container()
            ),
          ],
        ),
      ),
    );
  }
}
