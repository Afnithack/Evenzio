
import 'package:evenzio_new/user/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/loginProvider.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';
import 'otp.dart';

class loginpage extends StatelessWidget {
   loginpage({super.key});
  final _formKey = GlobalKey<FormState>();

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
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 150,),
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white
                ,
                child: Image.asset("assets/spoon.png"),
              ),
              text1(22, "Login"),
              SizedBox(
                height: 150,
              ),
              Consumer<LoginProvider>(
                builder: (context,value,child) {
                  return Form(key: _formKey,
                    child: Container(
                        height: 64,margin: EdgeInsets.symmetric(horizontal: 50),
                        width: width,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: tranceparent),
                        child: TextFormField(inputFormatters: [LengthLimitingTextInputFormatter(10)],
                          validator:(value) {
                          if(value==null||value.isEmpty){return "*Required ";}
                          return  null;
                          },keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          controller: value.phoneController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Phone",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                        )),
                  );
                }
              ),
              SizedBox(height: 30,),
              Consumer<LoginProvider>(
                builder: (context,value,child) {
                  return GestureDetector(

                    onTap: (){
                      if(_formKey.currentState!.validate()
                      ){
                        value.sendotp(context);

                      }





                    },
                    child:value.otploader?CircularProgressIndicator(color: Colors.black,): Container(


                      height: 50,margin: EdgeInsets.symmetric( horizontal: 100),
                      width: width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: maincolor),
                     child:Center(child: text2(16," Get OTP")) ,
                    ),
                  );
                }
              ),
              SizedBox(height: 50,),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal:70 ),
                child: Row(
                  children: [
                    text2(11, "Need An Account?"),
          SizedBox(width:5,),
          Consumer<MainProvider>(
            builder: (context,value,child) {
              return InkWell(
                onTap:
                (){
                  value.clearUsers();
                  callNext(context, registration(from: 'NEW',profileid: "",));
                },

                child: Text("REGISTER",style: GoogleFonts.inknutAntiqua(fontSize:12,fontWeight:
                FontWeight.w700,color: maincolor),

                ),
              );
            }
          ) ],
                ),
              ),





            ],
          ),
        ),
      ),
    );
  }
}

