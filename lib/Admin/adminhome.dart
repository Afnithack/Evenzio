import 'package:evenzio_new/Admin/problems.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/loginProvider.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';
import '../user/loginpage.dart';
import 'Categary.dart';
import 'Item.dart';
import 'Report.dart';
import 'Request.dart';
import 'mainCategory.dart';


class AdminHome extends StatelessWidget {



  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: bg,
      // appBar: AppBar(automaticallyImplyLeading: false,
      //   backgroundColor: maincolor,
      //
      //
      //
      //   leading: IconButton(
      //     onPressed: () {
      //       back(context);
      //
      //
      //     },
      //     icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
      //   ),
      //
      // ),
      body:
      Consumer<MainProvider>(
        builder: (context,value,child) {
          return SingleChildScrollView(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ClipPath(
        clipper: CustomShape(),
        child: Container(
          color: Colors.white,
          height: 200,
          child: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
backgroundColor: maincolor,
            automaticallyImplyLeading: false,

          ),
        ),
      ),
    InkWell(onTap: () {
      value.getadminorderdetils();

      callNext(context, Request());


    },
      child: Container(margin: EdgeInsets.all(20),height: height/11,width:width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                color: maincolor,),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text2(16, "Request"),
                    Icon(Icons.arrow_forward_ios_outlined,color: Colors.white),

                  ],
                ),
              ),
      ),
    ),
      InkWell(onTap: () {
        value.clearMaincategory();
        value.getItem();
        callNext(context, mainCategory());

      },
        child: Container(margin: EdgeInsets.all(20),height: height/11,width:width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: maincolor,),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text2(16, "Main Catogary"),
                  Consumer<MainProvider>(
                      builder: (context,value,child) {
                        value.getItem();

                        return  Icon(Icons.arrow_forward_ios_outlined,color: Colors.white);
                      }
                  )

                ],
              ),
            ),
        ),
      ),
            InkWell(onTap: () {
              callNext(context, catogary());


            },
              child: Container(margin: EdgeInsets.all(20),height: height/11,width:width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  color: maincolor,),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text2(16, "Add Catogary"),
    Consumer<MainProvider>(
              builder: (context,value,child) {
                value.getCategory();
                return Icon(Icons.arrow_forward_ios_outlined,color: Colors.white);
              }
    )

    ],
    ),
    ),
    ),
            ),

            InkWell(onTap:() {
              value.getItem();
              callNext(context, Items());
            },

              child: Container(margin: EdgeInsets.all(20),height: height/11,width:width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  color: maincolor,),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text2(16, "Add item"),
    Consumer<MainProvider>(
              builder: (context,value,child) {
                value.getItem();


                return  Icon(Icons.arrow_forward_ios_outlined,color: Colors.white);
              }
    )

    ],
    ),
    ),
    ),
            ),

            InkWell(onTap: () {
              value.getproblem();
              callNext(context, problems());


            },
              child: Container(margin: EdgeInsets.all(20),height: height/11,width:width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  color: maincolor,),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text2(16, "Report a problem"),
     Icon(Icons.arrow_forward_ios_outlined,color: Colors.white),

    ],
    ),
    ),
    ),
            ),

            InkWell(
              onTap: (){

                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(title: Center(child: text2(24, "Logout?")),
                      backgroundColor: color2,
                      content:
                      text2(16, "Do you want conform/reject"),
                      actions: [TextButton(onPressed: (){}, child: Text("Reject",style: GoogleFonts.inknutAntiqua
                        (fontSize:16,fontWeight: FontWeight.w700,color: red,),

                      )),
                        Consumer<LoginProvider>(
                          builder: (context,value,child) {
                            return TextButton(onPressed: (){


                              FirebaseAuth auth=FirebaseAuth.instance;
                              auth.signOut();
                              value.clearLogin();

                              callNextReplacement(context, loginpage());
                            }, child: Text("Confirm",style: GoogleFonts.inknutAntiqua
                              (fontSize:15,fontWeight: FontWeight.w700,color: Colors.white,),

                            ));
                          }
                        )],


                    ));

              },
              child: Container(margin: EdgeInsets.all(20),height: height/11,width:width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  color: color2,),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: text2(16, "Log Out")),
                ),
              ),
            ),
    ],
    ),
          );
        }
      ),






    );
  }
}
