import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';
import 'bottomnavigation.dart';
import 'getstartscreen.dart';

class details extends StatelessWidget {
  String userid;
  List itemid;
  String username;

   details({super.key,required this.userid,required this.itemid,required this.username,});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    List<String> itemimage=[
      "assets/watermelon.png",
      "assets/stage2.png",
      "assets/mint.png",
      "assets/broast.png",
      "assets/biriyani.png",
      "assets/mandhi.png",



    ];
    List<String> itemname=[
      "Watermelon",
      "Round stage",
      "Mint tea",
      "Broast ",
      "Chicken biriyani",
      "Chicken mandi",



    ];
    List<String> rate=[
      "RS:10(per)",
      "RS:8000/- ",
      "RS:10(per)",
      "RS:50(per)",
      "RS:100(per)",
      "RS:150(per)",



    ];
    return  Scaffold(
      backgroundColor: bg,
      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: maincolor,


        leading: IconButton(
          onPressed: () {
            back(context);


          },
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
        ),

      ),
      body:SingleChildScrollView(
        child:
        Column(
          children: [
            Container(margin: EdgeInsets.all(30),height: height/14,width: width,decoration:
            BoxDecoration(color: color2,borderRadius: BorderRadius.circular(10)),
              child: Center(child: text1(24,"Program Details")),


            ),

            Consumer<MainProvider>(builder: (context, value, child) {
              return Column(
                children: [
                  value.favoriteList.isNotEmpty?CarouselSlider.builder(
                    itemCount:value.favoriteList.length,
                    itemBuilder: (context, index, realIndex) {
                      var item= value.favoriteList[index];
                      return Container(margin:EdgeInsets.all(5),

                        decoration: BoxDecoration(

                            color: maincolor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(spreadRadius: 2,blurRadius: 2,color: Colors.grey),],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(item.photo))),
                        child:  Padding(
                          padding:  EdgeInsets.only(top: 100),
                          child: Container(height:50 ,width: 200,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Colors.white),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(item.name,style: GoogleFonts.inknutAntiqua(fontSize:11,fontWeight: FontWeight.w700,color: Colors.black),),

                                      Text(item.rate)
                                    ],
                                  ),
                                  SizedBox(width: 5,),
                                  Icon(Icons.favorite,color: Color(0xfffFF6464),size: 30,)
                                ],
                              )),
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
                          value.activeIndex(index);
                          // print("activvgvg"+Activeindex.toString());
                        }),
                  ):Text("Empty"),
                  // buildIndiCator(
                  //     value.Carosuelimg.length, context, value
                  //     .Activeindex),
                ],
              );
            }),


            Container(width: width,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white,),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Consumer<MainProvider>(
                    builder: (context,value,child) {
                      return Form(key: _formKey,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text2black(14, "Name"),
                            SizedBox(height: 5,),
                            tF3(1,value.orderNamecontroller),
                            SizedBox(height: 20,),

                            text2black(14, "Time"),
                            SizedBox(height: 5,),
                        Consumer<MainProvider>(
                          builder: (context,value,child) {
                            return Container(
                              decoration: BoxDecoration(color:  tranceparent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                keyboardType: TextInputType.none,
                                onTap: () {
                                value.selectTime(context);
                              },
                                validator: (value) {
                                if(value==null||value.isEmpty){return "*Required ";}
                                return  null;
                              }
                                ,style: GoogleFonts.inknutAntiqua(fontSize:12,fontWeight: FontWeight.w700,color: Colors.black),
                                controller: value.orderTimecontroller,
                                maxLines: 1,
                                decoration: InputDecoration(enabledBorder:OutlineInputBorder( borderSide:  BorderSide(color: Color(0xff297C90) ),
                                    borderRadius: BorderRadius.circular(5)
                                ) ,

                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)
                                    )
                                ),
                              ),

                            );
                          }
                        ),
                            SizedBox(height: 20,),
                            text2black(14, "Date"),


                            SizedBox(height: 5,),
                            Consumer<MainProvider>(
                                builder: (context,value,child) {
                                  return Container(
                                    decoration: BoxDecoration(color:  tranceparent,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: TextFormField(
                                      keyboardType: TextInputType.none,
                                      onTap: () {
                                        value.selectDate(context);
                                      },
                                      validator: (value) {
                                        if(value==null||value.isEmpty){return "*Required ";}
                                        return  null;
                                      }
                                      ,style: GoogleFonts.inknutAntiqua(fontSize:12,fontWeight: FontWeight.w700,color: Colors.black),
                                      controller: value.orderDatecontroller,
                                      maxLines: 1,
                                      decoration: InputDecoration(enabledBorder:OutlineInputBorder( borderSide:  BorderSide(color: Color(0xff297C90) ),
                                          borderRadius: BorderRadius.circular(5)
                                      ) ,

                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(5)
                                          )
                                      ),
                                    ),

                                  );
                                }
                            ),                            SizedBox(height: 20,),

                            text2black(14, "Function type "),
                            SizedBox(height: 5,),
                            tF3(1,value.ordertypecontroller),
                            SizedBox(height: 20,),

                            text2black(14, "Gust count"),
                            SizedBox(height: 5,),
                            tF4(1,value.orderGustcontroller),
                            SizedBox(height: 20,),

                            text2black(14, "Address"),
                            SizedBox(height: 5,),
                            tF3(3,value.orderAddresscontroller),


                            SizedBox(height: 20,),

                            Container(margin: EdgeInsets.only(left: 210),height: height/17,width: width,decoration: BoxDecoration(color:  color2,borderRadius: BorderRadius.circular(20),),
                             child: Center(child: InkWell(onTap: (){
                               if(_formKey.currentState!.validate()){
                               showDialog(
                               context: context,
                               builder: (ctx) => AlertDialog(
                               backgroundColor: color2,
                               content:
                               text2(16, "Do you want conform/reject"),
                               actions: [TextButton(onPressed: (){
                               back(context);
                               }, child: Text("Reject",style: GoogleFonts.inknutAntiqua
                               (fontSize:16,fontWeight: FontWeight.w700,color: Color(0xffFF6464),),

                               )),
                               Consumer<MainProvider>(
                               builder: (context,value,child) {
                                 print("fuivbufuhv"+itemid.length.toString());
                               return TextButton(onPressed: (){

                               value.addOrder(userid,itemid,context);
                               value.getuserorderdetils(userid);
                               // value.deletefavourate(itemid,context);
                               // value.deletefavouratelist(value.favoriteList.length,context);


                               // callNextReplacement(context, appointment());
                                 callNext(context, bottamNavigation(userId: userid,userName:userid ,itemid: itemid,));


                               }, child: Text("Confirm",style: GoogleFonts.inknutAntiqua
                               (fontSize:15,fontWeight: FontWeight.w700,color: Colors.white,),

                               ));
                               }
                               )],


                               ));
                               }



                             },
                                 child: text2(14, "Confirm"))),

                              )


                          ],
                        ),
                      );
                    }
                  ),
                ),



            ) ],
        ),

      )





    );
  }
}
