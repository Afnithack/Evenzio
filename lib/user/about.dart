import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../refactorin/widget.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Container(
      height: height,
      width: width,
      decoration: bgImg(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(automaticallyImplyLeading: false,
          backgroundColor: maincolor,
          title: text1(24, "About"),


          leading: IconButton(
            onPressed: () {
              back(context);


            },
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
          ),

        ),
body:Column(children: [
  Padding(
      padding: const EdgeInsets.all(20),
      child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: color2),height:height/1.9 ,width: width,child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: text2(15, "Create a seamless event planning experience with our catering service booking application. Users can effortlessly plan their events by selecting dates, venues, and catering services, all within an intuitive interface. Our app boasts a diverse catalog of catering options, complete with customizable menus to suit individual preferences. With a secure payment gateway and real-time availability tracking, users can finalize bookings with confidence. Stay informed through our robust notification system, ensuring users receive timely updates and confirmations, making event management a breeze.",


        ),
      )),
  ),

],)

 ),
    );
  }
}
