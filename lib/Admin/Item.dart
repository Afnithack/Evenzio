
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';
import 'AddItem.dart';

class Items extends StatelessWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return  Scaffold(
      backgroundColor:bg,
      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: maincolor,
        title: text1(24, "ItemList"),


        leading: IconButton(
          onPressed: () {
            back(context);


          },
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
        ),
      ),

      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Consumer<MainProvider>(
            builder: (context,value,child) {
              return FloatingActionButton(
                  shape:
                  CircleBorder(side: BorderSide(color: Colors.grey)),
                  backgroundColor: color2,
                  child: Icon(Icons.add,size: 35,color: Colors.white),
                  onPressed: () {
                    value.clearItem();
                    value.getCategory();
                    value.getMainCategory();

                    callNext(context, AddItem(from: "NEW",selectid: '',));



                  }
              );
            }
          )),

body:  Column( crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    SizedBox(height: 70,),
    Padding(
      padding:  EdgeInsets.only(left: 10),

    ),

    SizedBox(height: 10,),
    Expanded(
      child: Consumer<MainProvider>(
        builder: (context,value,child) {

          return ListView.builder(
            shrinkWrap: true,
            itemCount:value.itemList.length,
            itemBuilder: (context, index) {
              var item= value.itemList[index];
              return InkWell(onTap: (){
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
                                    Text(item.name,style: GoogleFonts.inknutAntiqua(fontSize:12,fontWeight: FontWeight.w700,color: Colors.black),),

                                    Text("${item.price}")
                                  ],
                                ),
                                // SizedBox(width: 20,),
                                Icon(Icons.favorite_border,color: Color(0xfffFF6464),size:40,)
                              ],
                            )),
                      ),
                    ),

                  ),
                );



              },
                onLongPress: (){

                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: color2,
                        content:
                        text2(16, "Do you want Delete/Edit"),
                        actions: [TextButton(onPressed: (){
                          // finish(context);
                          // value.editItem(value.itemList[index].id);
                          // callNext(context, AddItem(from: 'EDIT', selectid:value.itemList[index].id ,));



                        }, child: Consumer<MainProvider>(
                            builder: (context,value,child) {

                              return InkWell(onTap: (){
                                value.deleteItem(value.itemList[index].id, context);
                                finish(context);


                              },
                                child: Text("Delete",style: GoogleFonts.inknutAntiqua
                                  (fontSize:16,fontWeight: FontWeight.w700,color: Color(0xffFF6464),),

                                ),
                              );
                            }
                        )),
                          Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return TextButton(onPressed: (){

                                  finish(context);
                                  value.editItem(value.itemList[index].id);
                                  callNext(context, AddItem(from: 'EDIT', selectid:value.itemList[index].id ,));



                                }, child: Text("Edit",style: GoogleFonts.inknutAntiqua
                                  (fontSize:15,fontWeight: FontWeight.w700,color: Colors.white,),

                                ));
                              }
                          )],


                      ));
                },
                child: Container(margin: EdgeInsets.all(15),
                  height: height/13,width: width,decoration: BoxDecoration(color: color2,borderRadius: BorderRadius.circular(10) ,),
                  child: Center(child: text2(20, (item.name))),
                ),
              );
            },);
        }
      ),
    )
  ],
),


    );
  }
}
