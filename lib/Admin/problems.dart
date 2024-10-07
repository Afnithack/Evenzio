
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';

class problems extends StatelessWidget {
  
   problems({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return  Scaffold(
      backgroundColor: bg,

      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: maincolor,
        title: text1(24, "Problems"),


        leading: IconButton(
          onPressed: () {
            back(context);


          },
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
        ),
      ),
      body: Consumer<MainProvider>(
        builder: (context,value,child) {
          return ListView.builder(itemCount:value.problemlist.length,

              itemBuilder: (context, index){
            var item =value.problemlist[index];

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Container(height:height/5 ,width: width,
                decoration: BoxDecoration(color: color2,borderRadius: BorderRadius.circular(10),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text2(14, "name :"+item.username),
                    SizedBox(height: 10,),
                    text2(16, "Problem :"+item.Problem)
                  ],
                ),
              ),
            );

          }
          );
        }
      ));
  }
}
