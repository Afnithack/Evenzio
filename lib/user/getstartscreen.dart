import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';
import 'bottomnavigation.dart';

class home extends StatefulWidget {
  String userId;
  String userName;
   home({super.key,required this.userId,required this.userName});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;



    return  WillPopScope(onWillPop: ()  async{
      showExitPopup(context);
      return true;
      },
      child: Container(
        height: height,
        width: width,
        decoration: bgImg(),
        child: Scaffold(
          backgroundColor: tranceparent,
          appBar: AppBar(automaticallyImplyLeading: false,
              backgroundColor: maincolor),
          body: SingleChildScrollView(
            child: Column(
              children: [
      
                Consumer<MainProvider>(builder: (context, valu, child) {
                  return Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 3,
                        itemBuilder: (context, index, realIndex) {
                          final image = valu.Carosuelimg[index];
                          return SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  valu.Carosuelimg[index],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
      
                        options: CarouselOptions(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: 200,
                            viewportFraction: 1 / 2,
                            autoPlay: true,
                            pageSnapping: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            enlargeCenterPage: true,
                            autoPlayInterval: const Duration(seconds: 4),
                            onPageChanged: (index, reason) {
                              valu.activeIndex(index);
                              // print("activvgvg"+Activeindex.toString());
                            }),
                      ),
                      buildIndiCator(
                          valu.Carosuelimg.length, context, valu.Activeindex),
                    ],
                  );
                }),
                SizedBox(height: 10,),
                Padding(
                  padding:  EdgeInsets.all(15),
                  child:
                  Container(height: height/1.8,width: width,decoration:
                  BoxDecoration(boxShadow: [BoxShadow(spreadRadius: 2,blurRadius:3,color: Colors.grey)],borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),color:color2,
                  ),child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text2(20, "Our team features:-"),
                          SizedBox(height: 40,),
                          text2(14, "-Planning."),
                          SizedBox(height: 20,),
                          text2(14, "-Operation and execution of tasks."),
                          SizedBox(height: 20,),
                          text2(14, "-Organizing The Event."),
                          SizedBox(height: 20,),
                          text2(14, "-Eguipment."),
                          SizedBox(height: 20,),
                          text2(14, "-Implimentation."),
                          SizedBox(height: 20,),
                          text2(14, "-Controlling."),
                          SizedBox(height: 20,),
                          text2(13, "-Understanding Legal&Insurence issues."),
                        ],
                      ),
                    ),
                  ),    ),
                ),
                SizedBox(height: 10,),
      
                Padding(
                  padding:  EdgeInsets.only(left: 230),
                  child: Consumer<MainProvider>(
                    builder: (context,value,child) {
                      return InkWell(onTap: () {
                        value.getMainCategory();
                        // value.getCategory();
                        // value.getItem();
                        value.getUser();
                        value.getUserFavorite(widget.userId);
                        value.getReviews();
                        value.getUserPhoto(widget.userId, widget.userName);
                        value.getUserFcmId();
      
                        callNext(context, bottamNavigation(userId: widget.userId,userName: widget.userName,itemid: [widget.userId],));
                      },child: button("Get Start", 14, height/16, width/3.5,));
                    }
                  ),
                )
      
              ],
            ),
          ),
      
      
      
      
      
      
      
      
        ),
      
      ),
    );
  }
}
buildIndiCator(int count, BuildContext context, int activeindex) {
  //    print(activeIndex.toString()+"dpddoopf");


  return Center(
      child: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: AnimatedSmoothIndicator(
            activeIndex: activeindex,
            count: count,
            effect: const JumpingDotEffect(
                dotWidth: 7,
                dotHeight: 7,
                strokeWidth: 1,
                paintStyle: PaintingStyle.stroke,
                activeDotColor: Colors.grey,
                dotColor: Colors.white),
          ),
          ),
      );
}

Future<bool> showExitPopup(BuildContext CONTXT) async {

  return await showDialog(
      context: CONTXT,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: maincolor,
          content: SizedBox(
            height: 95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text2(15, "Do you want to EXIT ?"),
                const SizedBox(height: 19),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black12),
                          child: Center(child: text2(16, "Yes"))
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black12,
                          ), child: Center(child: text2(16, "No")),

                        ))
                  ],
                )
              ],
            ),
          ),
        );
      }
        );
  }



