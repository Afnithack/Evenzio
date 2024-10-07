
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';

class Juice extends StatelessWidget {
  String headname;
  String userId;

   Juice({super.key,required this.headname,required this.userId});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return  Container( height: height,
      width: width,
      decoration: bgImg(),
      child: Scaffold(
        backgroundColor: Colors.transparent,


        appBar: AppBar(automaticallyImplyLeading: false,
          backgroundColor: maincolor,


          leading: IconButton(
            onPressed: () {
              back(context);


            },
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
          ),
        ),

        body:
            Consumer<MainProvider>(
              builder: (context,value,child) {
                return Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70,),
                    Padding(
                      padding:  EdgeInsets.only(left: 10),
                      child: Text(headname,style: GoogleFonts.kavoon(fontSize:24,fontWeight: FontWeight.w400,color: Colors.white),),
                    ),
                    Divider(thickness: 2,color:  Colors.white,indent: 10,endIndent: 280,),

                    SizedBox(height: 10,),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:value.itemList.length,
                        itemBuilder: (context, index) {
                          var item=value.itemList[index];
                          return InkWell(onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(backgroundColor:Colors.transparent
                                  ,content:
                                Container(margin:EdgeInsets.all(25),height: height/3,width: width,
                                    decoration: BoxDecoration(

                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [BoxShadow(spreadRadius: 2,blurRadius: 2,color: Colors.grey),],
                                        image: DecorationImage(
                                            fit: BoxFit.cover,scale: 50,
                                            image: NetworkImage(item.photo))),
                                    child:  Padding(
                                      padding:  EdgeInsets.only(top: 170),
                                      child: Container(height: 100,width: 360,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Colors.white),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Column(mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(item.name,style: GoogleFonts.inknutAntiqua(fontSize:item.name.length >=10?10:15,fontWeight: FontWeight.w700,color: Colors.black),),

                                                  Text(item.price)
                                                ],
                                              ),
                                              // SizedBox(width: 20,),
                                              Consumer<MainProvider>(
                                                builder: (context,value,child) {
                                                  return IconButton(
                                                    onPressed: () {

                                                      value.addFavorite(context,userId, item.id, item.photo, item.name, item.price);
                                                      finish(context);



                                                    },
                                                    icon: Icon(Icons.favorite_border,color:Colors.red,size: 40,),
                                                  );
                                                }
                                              ),                                          ],
                                          )),
                                    ),
                                  ),

                                ),
                                );



                          },
                            child:
                            Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return Container(margin: EdgeInsets.all(15),
                                  height: height/13,width:width,decoration: BoxDecoration(color: color2,borderRadius: BorderRadius.circular(10) ,),
                                  child: Center(child: text2(20, item.name)),
                                );
                              }
                            ),
                          );
                        },),
                    )
                  ],
                );
              }
            ),




      ),
    );
  }
}
