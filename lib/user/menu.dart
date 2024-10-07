
import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';
import 'menuitemscreen.dart';

class menu extends StatelessWidget {
  String mainhead;
  String UserId;

  menu({super.key, required this.mainhead, required this.UserId});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      decoration: bgImg(),
      child: Scaffold(
        backgroundColor: tranceparent,
        appBar: AppBar(centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: maincolor,
            title: text1(22, mainhead),
            leading: IconButton(
              onPressed: () {
                back(context);
              },
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),

        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<MainProvider>(builder: (context, value, child) {
                return GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsetsDirectional.all(40),
                    itemCount: value.categoryList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 30,
                        crossAxisCount: 2,
                        childAspectRatio: 0.8),
                    itemBuilder: (BuildContext context, int index) {
                      var item = value.categoryList[index];
                      return InkWell(
                        onTap: () {
                          // print(item.id+"shm");
                          value.getuseritem(item.id);

                          callNext(
                              context,
                              Juice(
                                headname: item.name,
                                userId: UserId,
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: color3,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(item.photo),
                                  scale: 1.0)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 120),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)),
                                  color: color2,
                                ),
                                child: Center(child: text2(12, item.name))),
                          ),
                        ),
                      );
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
