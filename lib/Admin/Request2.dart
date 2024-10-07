import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';
import '../user/getstartscreen.dart';

class Request2 extends StatelessWidget {
  String id;
  String name;
  String Time;
  String Date;
  String Function;
  String Gustcount;
  String Address;



   Request2({super.key,
     required this.id,
     required this.name,
     required this.Time,
     required this.Date,
     required this.Function,
     required this.Gustcount,
     required this.Address});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // List<String> itemimage=[
    //   "assets/watermelon.png",
    //   "assets/stage2.png",
    //   "assets/mint.png",
    //   "assets/broast.png",
    //   "assets/biriyani.png",
    //   "assets/mandhi.png",
    //
    //
    //
    // ];
    // List<String> itemname=[
    //   "Watermelon",
    //   "Round stage",
    //   "Mint tea",
    //   "Broast ",
    //   "Chicken biriyani",
    //   "Chicken mandi",
    //
    //
    //
    // ];
    // List<String> rate=[
    //   "RS:10(per)",
    //   "RS:8000/- ",
    //   "RS:10(per)",
    //   "RS:50(per)",
    //   "RS:100(per)",
    //   "RS:150(per)",
    //
    //
    //
    // ];
    return  Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: Color(0xff297C90),


        leading: IconButton(
          onPressed: () {
            back(context);


          },
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
        ),

      ),
      body:
      SingleChildScrollView(
        child: Consumer<MainProvider>(builder: (context, value, child) {
          return Column(
            children: [
              SizedBox(
                child: CarouselSlider.builder(
                  itemCount:value.orderList.length,
                  itemBuilder: (context, index, realIndex) {
                    var item= value.orderList[index];
                    // print("jhfbvjhfbvjhfv"+value.orderList[index].itemname.toString());


                    return Container(
                      margin:EdgeInsets.all(5),height: height,width: width,
                      decoration: BoxDecoration(

                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(spreadRadius: 2,blurRadius: 2,color: Colors.grey),],
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(item.itemphoto))),
                      child:  Padding(
                        padding:  EdgeInsets.only(top: 150),
                        child: Container(height:50 ,width: 180,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Colors.white),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(item.itemname,style: GoogleFonts.inknutAntiqua(fontSize:11,fontWeight: FontWeight.w700,color: Colors.black),),

                                    Text(item.
                                    itemrate)
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
                      height: height/2.7,
                      viewportFraction: 1 /2,
                      autoPlay: false,
                      pageSnapping: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      enlargeCenterPage: true,
                      autoPlayInterval: const Duration(seconds: 4),
                      onPageChanged: (index, reason) {
                        value.activeIndex(index);
                        // print("activvgvg"+Activeindex.toString());
                      }),
                ),
              ),
              SizedBox(height: 20,),
             
              Consumer<MainProvider>(
                builder: (context,value,child) {



                  return Container(height: height/1.11,width: width,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text2black(12,"Name"),
                          SizedBox(height: 10,),
                          Container(height:height/16,width: width,decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: color2 ),

                         child: Padding(
                           padding: const EdgeInsets.all(10),
                           child: text2(14, name),
                         ), ),
                          SizedBox( height: 10,),
                          text2black(12,"Time"),
                          SizedBox(height: 10,),
                          Container(height:height/16,width: width,decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: color2 ),

                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: text2(14, Time),
                            ), ),
                          SizedBox( height: 10,),
                          text2black(12,"Date"),
                          SizedBox(height: 10,),
                          Container(height:height/16,width: width,decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: color2 ),

                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: text2(14, Date),
                            ), ),
                          SizedBox( height: 10,),
                          text2black(12,"Function Type"),
                          SizedBox(height: 10,),
                          Container(height:height/16,width: width,decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: color2 ),

                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: text2(14, Function),
                            ), ),
                          SizedBox( height: 10,),
                          text2black(12,"Gust Count"),
                          SizedBox(height: 10,),
                          Container(height:height/16,width: width,decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: color2 ),

                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: text2(14, Gustcount),
                            ), ),
                          SizedBox( height: 10,),
                          text2black(12,"Address"),
                          SizedBox(height: 10,),
                          Container(height:height/11,width: width,decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: color2 ),

                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: text2(14, Address),
                            ), ),
                          SizedBox( height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(actions: [
                                        TextButton(onPressed: (){

                                          back(context);
                                        }, child: Text("Reject",style: GoogleFonts.inknutAntiqua
                                          (fontSize:16,fontWeight: FontWeight.w700,color:red,),

                                        )),
                                        TextButton(onPressed: (){
                                          value.rejectStatusUpdate(id);
                                          value.getadminorderdetils();
                                          back(context);
                                        }, child: Text("Confirm",style: GoogleFonts.inknutAntiqua
                                          (fontSize:16,fontWeight: FontWeight.w700,color: Colors.white,),

                                        ))],


                                          backgroundColor:maincolor,content:

                                          Container(height: 150,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: text2(15, "GIve a Reason"),
                                                ),
                                                SizedBox(height: 10,),
                                                Container(

                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                                    child: TextField(maxLines: 2,
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10)),
                                                          hintText: "write something",
                                                          hintStyle: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.grey)),
                                                    )),



                                              ],
                                            ),

                                          ) ));


                                }
                                  ,
                                  child: Container(height: height/15, width: width/3,decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: maincolor),
                                  child: Center(
                                    child: Text("Reject",style: GoogleFonts.inknutAntiqua
                                      (fontSize:17,fontWeight: FontWeight.w700,color: red,),
                                    ),
                                  ),),
                                ),

                                InkWell(onTap: (){value.acceptStatusUpdate(id);
                                  value.getadminorderdetils();


                                  back(context);


                                },
                                  child: Container(height: height/15, width: width/3,decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: maincolor),
                                   child: Center(child: text2(17, "Accept")),
                                  ),
                                ),

                              ],
                            ),
                          )


                        ],
                      ),
                    ),




                  );
                }
              )
            ],
          );
        }),
      ),



    );
  }
}
