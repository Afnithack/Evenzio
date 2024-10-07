import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';

class mainCategory extends StatelessWidget {
  const mainCategory({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: maincolor,
        title: text1(24, "Main Category")

        ,
        leading: IconButton(
          onPressed: () {
            back(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: (){
                showBottomSheet(context);
              },
              child: Consumer<MainProvider>(builder: (context, value, child) {
                return value.mainfileImage != null
                    ? Container(
                    margin: EdgeInsets.all(100),
                    height: height / 5,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: Colors.white,
                          )
                        ],
                        color: maincolor),
                    child: Image.file(
                      value.mainfileImage!,
                      fit: BoxFit.fill,
                    ))
                    : value.mainimageUrl != ""
                    ? Container(
                    margin: EdgeInsets.all(100),
                    height: height / 5,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: Colors.white,
                          )
                        ],
                        color: maincolor),
                    child: Image.network(
                      value.mainimageUrl,
                      fit: BoxFit.fill,
                    ))
                    : Container(
                    margin: EdgeInsets.all(100),
                    height: height / 5,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: Colors.white,
                          )
                        ],
                        color: color3),
                    child: Icon(Icons.add_a_photo_outlined));
              }),
            ),
            Consumer<MainProvider>(builder: (context, value, child) {
              return Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: maincolor, borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLines: 1,
                  controller: value.mainNamecontroller,
                  decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: GoogleFonts.inknutAntiqua(
                          color: Colors.white, fontSize: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              );
            }),
            SizedBox(height: 100),
            Consumer<MainProvider>(builder: (context,value,child) {
              return InkWell(
                onTap: () {
                  // if(from=="NEW") {
                    value.addMainCategory("NEW", "",context);

                  // }
                  // else{
                  //   value.addCategory("EDIT", selectid,context);

                  // }


                }


                ,
                child: Container(
                  height: height / 17,
                  width: width / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: maincolor),
                  child: Center(child: text2(20, "Save")
                  ),

                ),
              );
            }
            )
          ],
        ),
      ),
    );
  }
}

void showBottomSheet(BuildContext context) {
  MainProvider provider = Provider.of<MainProvider>(context, listen: false);

  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          )),
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            ListTile(
                leading: Icon(
                  Icons.camera_enhance_sharp,
                  color: Colors.black,
                ),
                title: const Text(
                  'Camera',
                ),
                onTap: () =>
                {provider.getMainImagecamera(), Navigator.pop(context)}),
            ListTile(
                leading: Icon(Icons.photo, color: Colors.black),
                title: const Text(
                  'Gallery',
                ),
                onTap: () =>
                {provider.getMainImagegallery(), Navigator.pop(context)}),
          ],
        );
      });
  //ImageSource
}

