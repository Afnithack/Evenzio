
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constance/callfunctions.dart';
import '../constance/colors.dart';
import '../provider/loginProvider.dart';
import '../provider/mainprovider.dart';
import '../refactorin/widget.dart';

class Review extends StatefulWidget {
  String userId;
  String userName;
  Review({super.key, required this.userId,required this.userName});


  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  double? _ratingValue;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return  Container( height: height,
      width: width,
      decoration: bgImg(),
      child: Scaffold(
      backgroundColor:tranceparent,
      appBar: AppBar(automaticallyImplyLeading: false,
      backgroundColor: maincolor,


      leading: IconButton(
      onPressed: () {
      back(context);


      },
      icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
      ),

      ),

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Consumer<MainProvider>(
            builder: (context,value,child) {
              return FloatingActionButton(
                  shape:
                  CircleBorder(side: BorderSide(color: Colors.grey)),
                  backgroundColor: color2,
                  onPressed: () {


                    value.clearReview();

                    _ratingValue=null;



                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: text2(16, "Review"),
                          actions: [
                            SizedBox(width: width,
                              child: Row(

                                children: [

                                  RatingBar(
                                      initialRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      ratingWidget: RatingWidget(
                                          full: const Icon(Icons.star, color: Colors.orange),
                                          half: const Icon(
                                            Icons.star_half,
                                            color: Colors.orange,
                                          ),
                                          empty: const Icon(
                                            Icons.star_outline,
                                            color: Colors.orange,
                                          )),
                                      onRatingUpdate: (value) {
                                        setState(() {
                                          print("rty"+_ratingValue.toString());
                                          _ratingValue = value;
                                        });
                                      }),
                                  Text(
                                      _ratingValue != null ? _ratingValue.toString() : 'Rate it!',
                                      style: const TextStyle(color: Colors.white, fontSize: 9),
                                      ),






                                ],

                              ),
                            ),
                            Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return InkWell(onTap: (){
                                  value.addReviews(widget.userId,_ratingValue !,widget.userName);
                                  value.getReviews();
                                  finish(context);



                                },child: text2(15, "Add"));
                              }
                            )

                          ],
                          backgroundColor: maincolor,
                          content:
                          Consumer<MainProvider>(
                            builder: (context,value,child) {
                              return Container(

                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(maxLines: 3,
                                 style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                 controller: value.reviewController,
                                  decoration: InputDecoration(hintText: "Write a something",
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),

                                      )
                                  ),
                                ),


                              );
                            }
                          )
                        )









                    );

                    },
                  child: Icon(Icons.add,color: Colors.white,size: 35,)
              );
            }
          ),
        ),

        body:


        Consumer<MainProvider>(
          builder: (context,value,child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(physics: ScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsetsDirectional.all(30),
                      itemCount: value.reviewList.length,
                      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount 	(
                          mainAxisSpacing:10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 1,
                          childAspectRatio:1.6),
                      itemBuilder: (BuildContext context, int index) {
                        var item =value.reviewList[index];

                        return  InkWell(onLongPress: () {


                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Center(child: text2(24, "Delete?")),
                                backgroundColor: color2,
                                content:
                                text2(16, "Do you want delete"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        back(context);
                                      },
                                      child: Text(
                                        "No",
                                        style: GoogleFonts.inknutAntiqua(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: red,
                                        ),
                                      )),
                                  Consumer<MainProvider>(
                                      builder: (context, value, child) {
                                        return TextButton(
                                            onPressed: () {
                                              if(item.userid==widget.userId){
                                                value.deletereview(item.id,widget.userId,context);


                                              }
                                              else{
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  content: Text("Don't delete!!"),
                                                  backgroundColor: maincolor,
                                                ) );

                                              }
                                              finish(context);

                                            },
                                            child: Text(
                                              "Yes",
                                              style: GoogleFonts.inknutAntiqua(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ));
                                      })
                                ],
                              ));

                        },
                          child: Container(
                            margin:EdgeInsets.all(10),height:  height/2,width: width,
                            decoration: BoxDecoration(boxShadow: [BoxShadow(spreadRadius: 2,blurRadius: 2,color: Colors.grey)],borderRadius:BorderRadius.only
                              (topLeft: Radius.circular(20),bottomRight: Radius.circular(20),),color: color2 ),
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child:   Row(
                                  children: [
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [

                                        CircleAvatar(radius:40,backgroundImage: NetworkImage(value.photo,scale: 1.0),

                                        ),
                                        SizedBox(height: 10,),

                                        text2(14,widget.userName ),
                                        SizedBox(height: 10,),

                                        SizedBox(width:width/3.8,
                                          child: Row(
                                            children: [
                                              RatingBar(itemSize: 15,
                                                  initialRating: double.parse(item.rating),
                                                  direction: Axis.horizontal,
                                                  ignoreGestures: true,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  ratingWidget: RatingWidget(
                                                      full: const Icon(Icons.star, color: Colors.orange),
                                                      half: const Icon(
                                                        Icons.star_half,
                                                        color: Colors.orange,
                                                      ),
                                                      empty: const Icon(
                                                        Icons.star_outline,
                                                        color: Colors.orange,
                                                      )),
                                                  onRatingUpdate: (value) {
                                                    setState(() {
                                                      print("rty"+_ratingValue.toString());
                                                      _ratingValue = value;
                                                    });
                                                  }),
                                              Text(item.rating,
                                                style: const TextStyle(color: Colors.white, fontSize: 13),
                                              ),
                                            ],

                                          ),
                                        ),




                                      ],

                                    ),

                                    Column(
                                      children: [
                                        Divider(color: Colors.red,thickness: 50,indent: 10,endIndent: 10),
                                        SizedBox(height: 10,),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(width: width/2.5,height: height/8,child: text2(item.review.length >=10?10:13,item.review)),
                                        )
                                      ],
                                    )


                                  ],
                                ),


                              ),
                            ),

                          ),
                        );

                      }),
                  SizedBox(height: 50,)
                ],

              ),
            );

          }
        ),
      ),
    );
  }
}
