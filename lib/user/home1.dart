
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';
import 'decoration.dart';
import 'getstartscreen.dart';
import 'menu.dart';
import 'notification.dart';

class home1 extends StatefulWidget {
  String userId;

   home1({super.key,required this.userId});

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int currentIndex = 0;
    PageController pageController = PageController(initialPage:0);
    return  Container( height: height,
      width: width,
      decoration: bgImg(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: maincolor,
            leading: IconButton(
              onPressed: () {
                back(context);


              },
              icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
            ),
            actions: [
            IconButton(
            onPressed: () {

              callNext(context, notification());
            },
        icon: Icon(Icons.notifications,size: 33,color: Colors.white,),
      ),
            ]),




        body: Padding(
          padding:  EdgeInsets.only(left: 15),
          child: Consumer<MainProvider>(
            builder: (context,value,child) {
              return Column(mainAxisAlignment: MainAxisAlignment.center,

                children: [Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsetsDirectional.all(30),
                        itemCount: value.mainCategorylist.length,
                        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount 	(
                            mainAxisSpacing:20,
                            crossAxisSpacing: 10,
                            crossAxisCount: 1,
                            childAspectRatio:1.4),
                        itemBuilder: (BuildContext context, int index) {
                          var item= value.mainCategorylist[index];


                          return   InkWell(onTap: (){
                            value.getusercategory(item.id);


                            callNext(context, menu(mainhead: item.name,UserId:widget.userId));

                          },
                            child: Container
                                  (height: height/3.5,width: 360,decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(item.photo),fit:BoxFit.fill),boxShadow: [BoxShadow(spreadRadius:2,blurRadius:2,color: Colors.grey)],borderRadius:BorderRadius.circular(10,)
                                ),
                                  child: Padding(
                                    padding:  EdgeInsets.only(top: 150),
                                    child: Container(height: 60,width: 360,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:color2),
                                        child: Center(child: text1(24, item.name,))),
                                  )),
                          );











                        });
                  }
                )],

              );
            }
          ),
        ),


      ),
    );
  }
}
