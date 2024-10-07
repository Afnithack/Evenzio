import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constance/colors.dart';

BoxDecoration bgImg() {
  return BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
          image: AssetImage("assets/bg.png"),
          fit: BoxFit.fill,
          ));
}

// BoxDecoration bgImg2() {
//   return BoxDecoration(
//       color: Colors.white,
//       image: DecorationImage(
//         image: AssetImage("assets/background.png"),
//         fit: BoxFit.fill,
//       ));
// }


Widget text1(double size1,String name){
  return Text(name,style: GoogleFonts.kavoon(fontSize:size1,fontWeight: FontWeight.w400,color: Colors.white),);

}

Widget text2(double size1,String name){
  return Text(name,style: GoogleFonts.inknutAntiqua(fontSize:size1,fontWeight: FontWeight.w700,color: Colors.white),);


}
Widget text2black(double size1,String name){
  return Text(name,style: GoogleFonts.inknutAntiqua(fontSize:size1,fontWeight: FontWeight.w700,color: Colors.black),);


}

Widget tF2(double height, double width,){
  return Container(height: height,width: width,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(

        keyboardType: TextInputType.number,
          inputFormatters: [LengthLimitingTextInputFormatter(1)],
          decoration: InputDecoration(

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5)
              )
          ),
          ),

      );

}

tF3(int lins,TextEditingController control) {
  return Container(
    decoration: BoxDecoration(color:  tranceparent,
        borderRadius: BorderRadius.circular(10)),
    child: TextFormField(
      validator: (value) {
      if(value==null||value.isEmpty){return "*Required ";}
      return  null;
      }
      ,style: GoogleFonts.inknutAntiqua(fontSize:12,fontWeight: FontWeight.w700,color: Colors.black),
      controller: control,
      maxLines: lins,
      decoration: InputDecoration(enabledBorder:OutlineInputBorder( borderSide:  BorderSide(color: Color(0xff297C90) ),
          borderRadius: BorderRadius.circular(5)
      ) ,

          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)
          )
      ),
    ),

  );
}
tF4(int lins,TextEditingController control) {
  return Container(
    decoration: BoxDecoration(color:  tranceparent,
        borderRadius: BorderRadius.circular(10)),
    child: TextFormField(keyboardType: TextInputType.number,
      validator: (value) {
      if(value==null||value.isEmpty){return "*Required ";}
      return  null;
      }
      ,style: GoogleFonts.inknutAntiqua(fontSize:12,fontWeight: FontWeight.w700,color: Colors.black),
      controller: control,
      maxLines: lins,
      decoration: InputDecoration(enabledBorder:OutlineInputBorder( borderSide:  BorderSide(color: Color(0xff297C90) ),
          borderRadius: BorderRadius.circular(5)
      ) ,

          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)
          )
      ),
    ),

  );
}

Widget button(String name,double size,dynamic height,dynamic width,){

  return Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 2)],
                color: color2,
                border:
                Border.all(color: Colors.white.withOpacity(0))),
            child: Center(
              child:Text(name,style: GoogleFonts.inknutAntiqua(fontSize:size,fontWeight: FontWeight.w700,color: Colors.white
            ),
          )),
      ),
   ));
}


Widget textF(double height,double width,Color colors,String name,dynamic icons,TextEditingController cntlr,bool bool) {

  return

    Container(
        height: height,
        margin: EdgeInsets.symmetric(horizontal: 50),
        width: width,
        decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius:2,)],
            borderRadius: BorderRadius.circular(10), color:colors),
        child: TextFormField(
          controller: cntlr,
          enabled:bool ,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(prefixIcon: Icon(icons,color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),

              hintText: name,
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white)),
        ));

}
Widget box(){
  return Container(height: 60,width: 270,color: Colors.black,);


}
class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant oldClipper) {
    return true;
  }


}




