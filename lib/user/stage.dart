// import 'package:firstproject/constance/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../constance/callfunctions.dart';
//
// class stage extends StatelessWidget {
//   const stage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     List<String> itemimage=[
//     "assets/stage3.png",
//     "assets/stage2.png",
//     "assets/stage1.png",
//       "assets/stage4.jpg"
//
//   ];
//     return  Scaffold(
//       backgroundColor: bg,
//       appBar: AppBar(automaticallyImplyLeading: false,
//         backgroundColor: maincolor,
//
//
//         leading: IconButton(
//           onPressed: () {
//             back(context);
//
//
//           },
//           icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
//         ),
//       ),
//       body:
//       Column( crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//         SizedBox(height: 70,),
//       Padding(
//         padding:  EdgeInsets.only(left: 10),
//         child: Text("Stage works -",style: GoogleFonts.kavoon(fontSize:24,fontWeight: FontWeight.w400,color: Colors.black),),
//       ),
//       Divider(thickness: 2,color:  Colors.black,indent: 10,endIndent: 250,),
//
//       SizedBox(height: 10,),
//
//       Expanded(
//         child: GridView.builder(
//             shrinkWrap: true,
//             padding: EdgeInsetsDirectional.all(50),
//             itemCount: itemimage.length,
//             gridDelegate:SliverGridDelegateWithFixedCrossAxisCount 	(
//                 mainAxisSpacing:40,
//                 crossAxisSpacing: 20,
//                 crossAxisCount: 1,
//                 childAspectRatio: 2),
//             itemBuilder: (BuildContext context, int index) {
//               return InkWell(onTap: () {
//
//                 showDialog(
//                   context: context,
//                   builder: (ctx) => AlertDialog(backgroundColor:Colors.transparent
//                     ,content:
//                      Container(margin:EdgeInsets.all(25),height: height/3,width: width,
//           decoration: BoxDecoration(
//
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [BoxShadow(spreadRadius: 2,blurRadius: 2,color: Colors.grey),],
//               image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage("assets/stage2.png"))),
//           child:  Padding(
//             padding:  EdgeInsets.only(top: 190),
//             child: Container(height: 60,width: 360,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Colors.white),
//                 child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Round stage",style: GoogleFonts.inknutAntiqua(fontSize:24,fontWeight: FontWeight.w700,color: Colors.black),),
//
//                         Text("RS:8000/- ")
//                       ],
//                     ),
//                     SizedBox(width: 20,),
//                     Icon(Icons.favorite_border,color: Color(0xfffFF6464),size:40,)
//                   ],
//                 )),
//           ),
//         ),
//
//                   ),
//                 );
//
//               },
//                 child: Container(
//                    height: height , width: width,
//                   decoration: BoxDecoration(
//
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                             spreadRadius: 2, blurRadius: 2, color: Colors.grey),
//                       ],
//                       image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: AssetImage(itemimage[index]))),
//
//
//                 ),
//               );
//             } ),
//       )] ) );
//   }
// }
