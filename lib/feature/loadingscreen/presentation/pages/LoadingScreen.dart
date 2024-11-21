import 'package:flutter/material.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/IntroPage1.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/IntroPage2.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/IntroPage3.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/SkipDoneButton.dart';

class Loadingscreen extends StatefulWidget {
  const Loadingscreen({super.key});

  @override
  State<Loadingscreen> createState() => _LoadingscreenState();
}
//to keep track of page we're on
PageController _controller = PageController();
bool onLastPage = false;

class _LoadingscreenState extends State<Loadingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Stack(
       children: [

         //page view
         PageView(
           // check of the page is onthelast
           onPageChanged: (index){
             setState(() {
               onLastPage = (index == 2);
             });
           },
           controller: _controller,

           children: const [
            IntroPage1(),
             IntroPage2(),
             IntroPage3(),
           ],

         ),
        SkipDoneButton(
            controller: _controller,
            onLastPage: onLastPage
        ),
       ],

     )


    );
  }
}
