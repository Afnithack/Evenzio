import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';
import 'Request2.dart';


class Request extends StatelessWidget {

  const Request({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(

        backgroundColor: bg,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: maincolor,
        title: text1(22, "Request"),


        leading: IconButton(
          onPressed: () {
            back(context);


          },
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
        ),

      ),
      body: Consumer<MainProvider>(
          builder: (context,value,child) {
            return SizedBox(
              child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsetsDirectional.all(30),
                  itemCount: value.orderList.length,
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount 	(
                      mainAxisSpacing:10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 1,
                      childAspectRatio: 1.2),
                  itemBuilder: (BuildContext context, int index) {
                    var item =value.orderList[index];

                    return InkWell(onTap: () {

                      if(item.orderstatus=="Requested"){

                        value.getadminorderdetils();
                        callNext(context, Request2(id: item.orderid,name: item.ordername,Time: item.ordertime,Date: item.orderdate,Function: item.ordertype,Gustcount: item.ordergust,Address: item.orderaddress,));

                      }

                    },
                      child: Container(decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),color:color2),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child:   Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  text2(13, "Name:  "+item.ordername),
                                ],
                              ),
                              text2(13, "Time:  "+item.ordertime),
                              text2(13, "Date:  "+item.orderdate ),
                              text2(13, "Functioin Type: "+item.ordertype ),
                              text2(13, "Gust count:  "+item.ordergust),
                              text2(13, "Address :  "+item.orderaddress ),
                              SizedBox(height: 10,),

                              Center(child: Container(width: width/2,height:height/20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),child:Center(child: Text(item.orderstatus,style: GoogleFonts.kavoon(fontSize:15,fontWeight: FontWeight.w400,color: maincolor),))),
                              ) ],
                          ),
                        ),

                      ),
                    );
                  }),
            );
          }
      ) ,
    );
  }
}
