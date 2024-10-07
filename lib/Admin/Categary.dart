
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';
import 'AddCategory.dart';

class catogary extends StatelessWidget {
  const catogary({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    return  Scaffold(
      backgroundColor: bg,
      appBar: AppBar(automaticallyImplyLeading: false,
          backgroundColor: maincolor,
          title: text1(24, " Catoegory List"),


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
          value.clearcategory();
          value.getMainCategory();

          callNext(context, AddCategory(from: "NEW",selectid: '',));



        }
        );
      }
    )),
    body:




       Column(
        children: [
          Expanded(
            child: Consumer<MainProvider>(
              builder: (context,value,child) {
                return GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsetsDirectional.all(50),
                    itemCount: value.Categorylist.length,
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount 	(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 30,
                        crossAxisCount: 2,
                        childAspectRatio: 0.8),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(onLongPress:  (){
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              backgroundColor: color2,
                              content:
                              text2(16, "Do you want Delete/Edit"),
                              actions: [TextButton(onPressed: (){



                              }, child: Consumer<MainProvider>(
                                builder: (context,value,child) {

                                  return InkWell(onTap: (){
                                    value.deletecategory(value.Categorylist[index].id, context);
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

                                      value.editcategory(value.Categorylist[index].id);
                                      callNext(context, AddCategory(from: 'EDIT', selectid:value.Categorylist[index].id ,));



                                    }, child: Text("Edit",style: GoogleFonts.inknutAntiqua
                                      (fontSize:15,fontWeight: FontWeight.w700,color: Colors.white,),

                                    ));
                                  }
                                )],


                            ));



                      },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(value.Categorylist[index].photo))),
                          child:  Padding(
                            padding:  EdgeInsets.only(top: 120),
                            child: Container(height: 60,width: 360,decoration: BoxDecoration(color: color2,),
                                child: Center(child: text2(10
                                    , value.Categorylist[index].name))),
                          ),
                        ),
                      );
                    });
              }
            ),
          ),
        ],
      ),



     );
  }
}
