import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Models/categorymodel.dart';
import '../Models/mainCategoryModel.dart';
import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';

class AddItem extends StatelessWidget {
  String from;
  String selectid;

  AddItem({super.key, required this.from, required this.selectid});


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: bg,
      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: maincolor,
        title: text1(24, "Add Item"),


        leading: IconButton(
          onPressed: () {
            back(context);


          },
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(onTap: (){
              showBottomSheet(context);
              
            },


              child: Consumer<MainProvider>(
                builder: (context,value,child) {
                  return value.itemFileImage != null
                    ?
                  Container(margin:EdgeInsets.all(20) ,
                    height: height/5,width: width/2,
                    decoration: BoxDecoration

                    (borderRadius: BorderRadius.circular(20),boxShadow: [BoxShadow
                    (spreadRadius: 2,blurRadius: 2,color: Colors.grey,)],color: maincolor
                  ),
                    child:  Image.file(
                    value.itemFileImage!,
                    fit: BoxFit.fill,
                  ),) : value.itemImageUrl != ""
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
                        value.itemImageUrl,
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

child:  Icon(Icons.add_a_photo_outlined,size: 40,color: Colors.white,),

                  );
                }
              ),
            ),
            SizedBox(height: 40,),
            Consumer<MainProvider>(
              builder: (context,value,child) {
                return Container(margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: maincolor,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(maxLines: 1,
                    controller: value.itemNameController,

                    decoration: InputDecoration(
                        hintText: "Name",hintStyle:GoogleFonts.inknutAntiqua (color: Colors.white,fontSize: 18),

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    ),
                  ),


                );
              }
            ),

            // Container(margin: EdgeInsets.all(20),
            //   decoration: BoxDecoration(color: maincolor,
            //       borderRadius: BorderRadius.circular(10)),
            //   child: TextField(maxLines: 1,
            //
            //     decoration: InputDecoration(
            //         hintText: "Category",hintStyle:GoogleFonts.inknutAntiqua (color: Colors.white,fontSize: 18),
            //         suffixIcon: Icon(Icons.keyboard_arrow_down,size: 40,color: Colors.white,),
            //
            //
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(5)
            //         )
            //     ),
            //   ),
            //
            //
            // ),

            Consumer<MainProvider>(
              builder: (context,value,child) {
                return Container(margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: maincolor,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(maxLines: 1,
                    controller: value.itemRateController,

                    decoration: InputDecoration(
                        hintText: "Rate",hintStyle:GoogleFonts.inknutAntiqua (color: Colors.white,fontSize: 18),

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    ),
                  ),


                );
              }
            ),

            SizedBox(
              width: width / 1.5,
              child: Consumer<MainProvider>(
                  builder: (context, value, child) {
                    return Autocomplete<Categorymodel>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return value.Categorylist
                            .where((Categorymodel item) => item.name
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (Categorymodel option) =>
                      option.name,
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          // fieldTextEditingController.text =
                          //     value.itemController.text;
                        });

                        return SizedBox(
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(15),
                            child: TextFormField(
                              decoration: InputDecoration(

                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                hintStyle: const TextStyle(color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat"),
                                fillColor: maincolor,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),

                                hintText:"Select Category",

                                suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              // validator: (value2) {
                              //   if (value2!.trim().isEmpty ||
                              //       !value.mainCategorylist
                              //           .map((item) => item.name)
                              //           .contains(value2)) {
                              //     return "Please Select Your Category";
                              //   } else {
                              //     return null;
                              //   }
                              // },
                              onChanged: (txt) {},
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                            ),
                          ),
                        );
                      },
                      onSelected: (Categorymodel selection) {
                        value.itemController.text =
                            selection.name;
                        value.productSelectedItemID = selection.id;
                        // value.productSelectedCategoryId = selection.id;
                      },
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<Categorymodel> onSelected,
                          Iterable<Categorymodel> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width /1.5,
                              height: MediaQuery.of(context).size.height/5,
                              color: Colors.white,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final Categorymodel option =
                                  options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.86,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(option.name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),

                                            const SizedBox(height: 10)
                                          ]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );


                  }),
            ),
            SizedBox(height: 30,),

            SizedBox(
              width: width / 1.5,
              child: Consumer<MainProvider>(
                  builder: (context, value, child) {
                    return Autocomplete<mainCategorymodel>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return value.mainCategorylist
                            .where((mainCategorymodel item) => item.name
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (mainCategorymodel option) =>
                      option.name,
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          // fieldTextEditingController.text =
                          //     value.itemController.text;
                        });

                        return SizedBox(
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(15),
                            child: TextFormField(
                              decoration: InputDecoration(

                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                hintStyle: const TextStyle(color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat"),
                                fillColor: maincolor,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),

                                hintText:"Select Main Category",

                                suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              // validator: (value2) {
                              //   if (value2!.trim().isEmpty ||
                              //       !value.mainCategorylist
                              //           .map((item) => item.name)
                              //           .contains(value2)) {
                              //     return "Please Select Your Category";
                              //   } else {
                              //     return null;
                              //   }
                              // },
                              onChanged: (txt) {

                              },
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                            ),
                          ),
                        );
                      },
                      onSelected: (mainCategorymodel selection) {
                        value.itemsController.text =
                            selection.name;
                        value.productSelectedItemid= selection.id;
                        // value.productSelectedCategoryId = selection.id;
                      },
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<mainCategorymodel> onSelected,
                          Iterable<mainCategorymodel> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width /1.5,
                              height: MediaQuery.of(context).size.height/5,
                              color: Colors.white,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final mainCategorymodel option =
                                  options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.86,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(option.name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),

                                            const SizedBox(height: 10)
                                          ]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );


                  }),
            ),




            SizedBox(height: 100,),



            Consumer<MainProvider>(
              builder: (context,value,child) {
                return InkWell(onTap: (){
                  if(from=="NEW") {
                    value.addItem("NEW", "",context);
                  }
                  else{
                    value.addItem("EDIT", selectid,context);

                  }
                  back(context);

                },
                  child: Container(height: height/17,width: width/3,decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20),color: maincolor),
                    child: Center(child: text2(20, "Save")),),
                );

              }
            ),
            SizedBox(height: 100,),

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
                {provider.itemGetImagecamera(), Navigator.pop(context)}),
            ListTile(
                leading: Icon(Icons.photo, color: Colors.black),
                title: const Text(
                  'Gallery',
                ),
                onTap: () =>
                {provider.itemGetImagegallery(), Navigator.pop(context)}),
          ],
        );
      });
  //ImageSource
}

