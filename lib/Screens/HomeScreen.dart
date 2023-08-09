import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Screens/EntertainmentNewsScreen.dart';
import 'package:news_app/Screens/HealthNewsScreen.dart';
import 'package:news_app/Screens/ScienceNewsScreen.dart';
import 'package:news_app/Screens/SportsNewsScreen.dart';
import 'package:news_app/Screens/Top_Headlines_Screen.dart';

import 'BusinessNewsScreen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imgSource= [
    "lib/Images/img1.jpg",
    "lib/Images/img2.jpg",
    "lib/Images/img3.jpg",
    "lib/Images/img4.jpg",
    "lib/Images/img5.jpg"
];

  List<Widget> Routes =[
    BusinessNewsScreen(),
    EntertainmentNewsScreen(),
    ScienceNewsScreen(),
    HealthNewsScreen(),
    SportstNewsScreen(),
  ];

  List<String> imgName= ["Business","Entertainment","Science and Technology","Health","Sports"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Indian ",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1,color: Colors.white,fontSize: 25.sp),),
            Text("NEWS",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1,color:Colors.blueAccent,fontSize: 25.sp),),
          ],
        ),),
      body:Column(
        children: [
          Text("Categories",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
          Container(
            height: 120.h,
            child: ListView.builder(
              itemCount: imgSource.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Routes[index]; //routing
                          },));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left:8,top:8 ,bottom:8 ,right:8 ),
                          child: Container(
                            height: 80.h,
                            width: 140.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(width: 2.w,color: Colors.black),
                              image: DecorationImage(image: AssetImage(imgSource[index]),fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                      Text(imgName[index],style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),)
                    ],
                  );
                },),
          ),
          Row(
            children: [
              Expanded(child: Divider(indent: 10.w,thickness: 2.sp,endIndent: 10.w)),
              Text(" News ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Expanded(child: Divider(indent: 10.w,thickness: 2.sp,endIndent: 10.w)),
            ],
          ),
          Expanded(child: TopHeadlinesScreen()),
        ],
      ),
    );
  }
}
