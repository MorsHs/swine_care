import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swine_care/colors/colors.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/IntroPage1.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/IntroPage2.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/IntroPage3.dart';
import 'package:swine_care/feature/login/presentation/pages/Login.dart';

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
         Container(
           alignment: const Alignment(0, 0.75),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 // SKIP BUTTON
                 GestureDetector(
                   onTap: (){
                     _controller.jumpToPage(2);
               },
                     child: const Text("skip")
                 ),

                 SmoothPageIndicator(
                     controller: _controller, count: 3
                 ),

                 onLastPage ?
                 GestureDetector(
                     onTap: (){
                       Navigator.push(
                           context, MaterialPageRoute(builder: (context) {
                             return const Login();
                       },),);
                     },
                     child: const Text("done")
                 )

                 // NEXT BUTTON
                     : GestureDetector(
                     onTap: (){
                       _controller.nextPage(
                           duration: const Duration(
                               milliseconds: 300), curve: Curves.easeIn);
                     },
                     child: const Text("next")
                 )

               ],
             )
         )
       ],

     )


    );
  }
}
