import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/topHeadlinesNewsModel.dart';
import 'package:url_launcher/url_launcher.dart';

class TopHeadlinesScreen extends StatefulWidget {
  const TopHeadlinesScreen({Key? key}) : super(key: key);
  @override
  State<TopHeadlinesScreen> createState() => _TopHeadlinesScreenState();
}


class _TopHeadlinesScreenState extends State<TopHeadlinesScreen> {
  Future<TopHeadlinesNewsModel> getTopHeadlinesNews() async {
    String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=090c008511454296a2e233a6b2e42433";
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return TopHeadlinesNewsModel.fromJson(data);
    } else {
      return TopHeadlinesNewsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<TopHeadlinesNewsModel>(
        future: getTopHeadlinesNews(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.articles!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async{
                      /// ======== URL to news ===========
                      var url = Uri.parse(snapshot.data!.articles![index].url.toString());
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200.h,width: double.infinity,
                          decoration:  BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(snapshot.data!.articles![index].urlToImage.toString()),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        Text(snapshot.data!.articles![index].title.toString(),style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold)),
                        Text(snapshot.data!.articles![index].description.toString(),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.normal)),
                        Text("Author: ${snapshot.data!.articles![index].author.toString()}",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold)),
                        Text("Published at: ${snapshot.data!.articles![index].publishedAt.toString()}",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                );
              },);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
