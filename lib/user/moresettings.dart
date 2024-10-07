import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';
import 'about.dart';

class settings extends StatelessWidget {
  String userid;
  String username;
   settings({super.key,required this.userid,required this.username});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Container( height: height,
      width: width,
      decoration: bgImg(),
      child: Scaffold(

        backgroundColor: tranceparent,
        appBar: AppBar(automaticallyImplyLeading: false,
            backgroundColor: maincolor,
            title: text1(24, "More Settings"),
            centerTitle: true,


            leading: IconButton(
              onPressed: () {
                back(context);


              },
              icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
            ),

        ),
        body: Center(
            child:
            Stack(
              children:[Container(height: height/2.3,margin: EdgeInsets.all(40),width: width,
                decoration: BoxDecoration(boxShadow: [BoxShadow(spreadRadius: 2,color: Colors.grey,blurRadius: 2)],borderRadius: BorderRadius.circular(20),
                    color: Color(0xffD9D9D9)),
              ),
                Positioned(top: 60,left: 60,
                  child: Column(
                    children: [
                      Container(height: height/12,width:width/1.5,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color: Color(0xff297C90),),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              text2(16, "About"),
                          IconButton(
                            onPressed: () {

callNext(context, About());




                            },
                            icon: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white),)

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(height: height/12,width:width/1.5,                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: Color(0xff297C90),),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              text2(16, "Report problem"),
                              Consumer<MainProvider>(
                                builder: (context,value,child) {
                                  return IconButton(
                                    onPressed: () {

                                      value.clearProblems();
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                              title: text2(16, "Report problem"),
                                              actions: [

                                                Consumer<MainProvider>(
                                                    builder: (context,value,child) {
                                                      return InkWell(onTap: (){
                                                        value.addProblems(userid,username);
                                                        finish(context);




                                                      },child: text2(16, "Submit"));
                                                    }
                                                )

                                              ],
                                              backgroundColor: maincolor,
                                              content:
                                              Consumer<MainProvider>(
                                                  builder: (context,value,child) {
                                                    return Container(

                                                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.5),
                                                          borderRadius: BorderRadius.circular(10)),
                                                      child: TextField(
                                                        style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white ),
                                                        maxLines: 3,
                                                        controller: value.problemcontroller,
                                                        decoration: InputDecoration(hintText: "Write a something",
                                                            hintStyle: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.white),


                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(5),

                                                            )
                                                        ),
                                                      ),


                                                    );
                                                  }
                                              )
                                          )









                                      );


                                      // callNext(context, settings());

                                    },
                                    icon: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white),);
                                }
                              )

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),

                      Container(height: height/12,width:width/1.5,                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: Color(0xff297C90),),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              text2(16, "Share"),
                              IconButton(
                                onPressed: () {
                                  // callNext(context, settings());

                                },
                                icon: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white),)

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),

                      Container(height: height/12,width:width/1.5,                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: Color(0xff297C90),),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              text2(16, "Contact"),
                              IconButton(
                                onPressed: () {
                                  // callNext(context, settings());

                                },
                                icon: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white),)

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


              ]
            )),

      ),
    );
  }
}
