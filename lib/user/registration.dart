
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';
import 'loginpage.dart';

class registration extends StatelessWidget {
  String from;
  String  profileid;
   registration({super.key,required this.from,required this.profileid});


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      decoration: bgImg(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: height * 0.3,

            flexibleSpace: const Image(
              image: AssetImage('assets/Ellipse 4.png'),
              fit: BoxFit.fill,
            ),
            backgroundColor: Colors.transparent,
title:  Center(
  child:   Padding(
    padding: const EdgeInsets.only(bottom: 70),
    child: Column(
      children: [
        CircleAvatar(

          radius: 45,

          backgroundColor: maincolor,

          child: Image.asset("assets/person.png"),



        ),
        from=="NEW"?
        text1(24, "Registration"
            ):
            SizedBox(),


      ],

    ),
  ),
),

           ),
        body:  SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height:24),
              from=="EDIT"?
              InkWell(onTap: ()
                {
               showBottomSheet(context,);

                },

                child: Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return value.profilimage!=null?
                    CircleAvatar(backgroundImage: FileImage(value.profilimage!),
                      radius: 45,):value.profilimageurl!=""?
                    CircleAvatar(backgroundImage: NetworkImage(value.profilimageurl),
                        radius: 45,):
                    CircleAvatar(
                          radius: 45,backgroundColor: maincolor,child: Icon(Icons.add_a_photo_outlined,color: Colors.white,size: 25,),);
                  }
                ),

              )
                  :SizedBox(),
              SizedBox(height: height/12,),
              Consumer<MainProvider>(
                builder: (context,value,child) {

                  return textF(50, 350, tranceparent, "Fullname",Icons.person,value.userNameController,true);
                }
              ),
              SizedBox(height: height/20,),
              Consumer<MainProvider>(
                builder: (context,value,child) {
                  return textF(50, 350, tranceparent, "Address",Icons.home,value.userAddresController,true);
                }
              ),
              SizedBox(height: height/20,),
              Consumer<MainProvider>(
                builder: (context,value,child) {
                  return textF(50, 350, tranceparent, "Phone", Icons.phone,value.userPhoneController,from=="EDIT"?false:true);
                }
              ),
              SizedBox(height: height/20,),


              Consumer<MainProvider>(
                builder: (context,value,child) {
                  return InkWell(onTap: () {
                    if(from=="NEW"){
                      value.AddUsers("NEW","");
                      callNext(context, loginpage());
                    }else{
                      value.AddUsers("EDIT",profileid);
                      finish(context);
                    }


                  },child:from=="NEW" ?button("REGISTER",16, height/18, width/2,):
                  button("UPDATE",16, height/18, width/2,)
                  );
                }
              )




            ],

          ),
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
                {provider.profilImagecamera(), Navigator.pop(context)}),
            ListTile(
                leading: Icon(Icons.photo, color: Colors.black),
                title: const Text(
                  'Gallery',
                ),
                onTap: () =>
                {provider.profilImagegallery(), Navigator.pop(context)}),
          ],
        );
      });
  //ImageSource
}
