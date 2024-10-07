// import 'package:firstproject/constance/callfunctions.dart';
// import 'package:firstproject/constance/colors.dart';
// import 'package:firstproject/user/stage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../refactorin/widget.dart';
// import 'otp.dart';
//
// class decoration extends StatelessWidget {
//   const decoration({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> itamimage=[
//       "assets/stage.png",
//       "assets/counter.png",
//       "assets/table.png",
//
//
//
//     ];
//     List<String> itamname= [
//       "Stage Works",
//       "Table settings",
//       "Counter settings",
//
//
//     ];
//
//
//     return Scaffold(
//       backgroundColor: bg,
//       appBar: AppBar(automaticallyImplyLeading: false,
//           backgroundColor: maincolor,
//           title: Center(child: text1(24, "DECORATION")),
//
//
//           leading: IconButton(
//             onPressed: () {
//               back(context);
//
//
//             },
//             icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
//           ),
//         ),
//
//       body:
//       GridView.builder(
//           padding: EdgeInsetsDirectional.all(50),
//           itemCount: itamimage.length,
//           gridDelegate:SliverGridDelegateWithFixedCrossAxisCount 	(
//               mainAxisSpacing: 30,
//               crossAxisSpacing: 30,
//               crossAxisCount: 2,
//               childAspectRatio: 0.8),
//           itemBuilder: (BuildContext context, int index) {
//             return InkWell(onTap: (){
//              callNext(context, stage());
//
//             }
//
//
//
//               ,
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
//                     image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage(itamimage[index]))),
//                 child:  Padding(
//                   padding:  EdgeInsets.only(top: 120),
//                   child: Container(height: 60,width: 360,decoration: BoxDecoration(color: maincolor,),
//                       child: Center(child: text2(13, itamname[index]))),
//                 ),
//               ),
//             );
//           }),
//
//
//
//
//
//
//
//
//     );
//   }
// }
