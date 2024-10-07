
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';
import 'details.dart';

class favorite extends StatelessWidget {
  String userid;
  List itemid;  String username;
  favorite({super.key,required this.userid,required this.itemid,required this.username,});

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


          leading: IconButton(
            onPressed: () {
              back(context);


            },
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Consumer<MainProvider>(
            builder: (context,value,child) {
              return FloatingActionButton(
                shape: CircleBorder(),
                backgroundColor: color2,
                onPressed: () {
                  if(value.favoriteList.isNotEmpty){
                    print("jnfvbjkgnv"+itemid.length.toString());
                    value.clearorder();
                    value.getallitems(userid);

                    callNext(context, details(userid:  userid,itemid:value.itemid,username: username,));

                  }else{

                  }

                },
                child: text2(10, "Order"),

              );
            }
          ),
        ),

        body:  Consumer<MainProvider>(
          builder: (context,value,child) {
            return value.favoriteList.isNotEmpty? Column(
              children: [
               Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsetsDirectional.all(30),
                      itemCount: value.favoriteList.length,
                      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount 	(
                          mainAxisSpacing:10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2,
                          childAspectRatio: 0.8),
                      itemBuilder: (BuildContext context, int index) {
                        var item= value.favoriteList[index];

                        return InkWell(onTap: (){


                        },
                          child:  Container(margin:EdgeInsets.all(5),height: height/3,width: width,
                            decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [BoxShadow(spreadRadius: 2,blurRadius: 2,color: Colors.grey),],
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(item.photo))),
                            child:  Padding(
                              padding:  EdgeInsets.only(top: 120),
                              child: Container(height:50 ,decoration: BoxDecoration(borderRadius:BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),color:Colors.white),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: width/4,
                                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(item.name,style: GoogleFonts.inknutAntiqua(fontSize: item.name.length >=10?10:10,fontWeight: FontWeight.w700,color: Colors.black),),

                                            Text(item.rate)
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      InkWell(onTap: () {
                                        value.removeFavorite(value.favoriteList[index].favid, context,userid);

                                      },child: Icon(Icons.favorite,color: Color(0xfffFF6464),size: 30,))
                                    ],
                                  )),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ):Center(child: text2(13, "Your Favorite is Empty....")
            // Text(" Your Favorite is Empty....",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
            // )
            );
          }
        ),

      ),
    );
  }
}
