import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../refactorin/widget.dart';

class notification extends StatelessWidget {

  const notification({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:bg,
      appBar: AppBar(automaticallyImplyLeading: false,
          backgroundColor:maincolor,
          title: Center(child: text1(24, "NOTIFICATION")),


          leading: IconButton(
            onPressed: () {
              back(context);


            },
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
          ),
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.notifications_none,size: 33,color: Colors.white,),
          //   ),
          ),
      body:

      Padding(
        padding:  EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(height:height/9,width: 350,decoration: BoxDecoration(borderRadius:
              BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),color: maincolor,),
              child:Center(child: text2(16, "Your booking has been requested"))
              ),
              SizedBox(height: 50,),
              Container(height:height/4,width: 350,decoration: BoxDecoration(borderRadius:
              BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),color: maincolor,),
                  child:Column(mainAxisAlignment: MainAxisAlignment.center
                    ,
                    children: [
                   Center(
                        child: text2(15, "your booking on 19/10/2023 ,at 12:30\nis accepted,you have to make payment\nafter work"



              ),
                      ),
                InkWell(onTap: (){
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(actions: [
                        TextButton(onPressed: (){}, child: Text("Reject",style: GoogleFonts.inknutAntiqua
                          (fontSize:16,fontWeight: FontWeight.w700,color: red,),

                        )),
                          TextButton(onPressed: (){}, child: Text("Confirm",style: GoogleFonts.inknutAntiqua
                            (fontSize:16,fontWeight: FontWeight.w700,color: Colors.white,),

                          ))],


                      backgroundColor: maincolor,content:

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


                },
                    child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 35 ,
                            width: 90,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border:
                                Border.all(color: Colors.white.withOpacity(0))),
                            child: Center(
                                child:Text("Cancel",style: GoogleFonts.inknutAntiqua(fontSize:16,fontWeight:
                                FontWeight.w700,color: maincolor
                                ),
                                )),
                          ),
                        ))),
                    ],
                  ),
                
                
                



              ),
              SizedBox(height: 50,),
              Container(height:height/9,width: 350,decoration:
              BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft:
              Radius.circular(20)),color: maincolor,),
                  child:Center(child: text2(16, "Your booking has been reject"))
              ),



            ],
          ),
        ),
      ),




    );
  }
}
