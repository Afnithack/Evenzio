
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../refactorin/widget.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: bg,

      appBar: AppBar(automaticallyImplyLeading: false,
       centerTitle: true,
        title: text1(20, "Report Problem"),
        backgroundColor: maincolor,


        leading: IconButton(
          onPressed: () {
            back(context);


          },
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
        ),
      ),
      
      body:
      Container(margin:EdgeInsets.all(50),height:height/5,width: width, decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: maincolor
      ),
      child: Center(child: Column(mainAxisAlignment:MainAxisAlignment.center ,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text2(16, "User name: Thasleema"),
          SizedBox(height: 20,),
          text2(16, "Problem    : Not work reject"),

        ],
      )),
      ),

    );
  }
}
