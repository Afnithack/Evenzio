
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';


class appointment extends StatelessWidget {
  const appointment({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(

      backgroundColor: bg,
      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: maincolor,
        title: text1(22, "Appointment"),


        leading: IconButton(
          onPressed: () {
            back(context);


          },
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
        ),

      ),
      body: Consumer<MainProvider>(
        builder: (context,value,child) {
          return GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.all(30),
              itemCount: value.orderList.length,
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount 	(
                  mainAxisSpacing:10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 1,
                  childAspectRatio: 1.5),
              itemBuilder: (BuildContext context, int index) {
                var item =value.orderList[index];

                return Container(decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),color:color2),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child:   SizedBox(height: 100,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              text2(13, "Name:  "+item.ordername),
                            ],),
                      text2(13, "Time:  "+item.ordertime),
                   text2(13, "Date:  "+item.orderdate ),
                          text2(13, "Functioin Type: "+item.ordertype),
                          text2(13, "Gust count:  "+item.ordergust),
                          text2(13, "Address :  "+item.orderaddress ),
                        ],
                      ),
                    ),
                  ),

                );
              });
        }
      ) ,
    );
  }
}
