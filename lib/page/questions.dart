import 'package:do_nasi/page/add_question.dart';
import 'package:do_nasi/page/question_detail.dart';
import 'package:do_nasi/utils/fetch_questions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:do_nasi/model/post.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  Future<List<Post>> fetchPosts() async {
    var url =
        Uri.parse(
          'https://do-nasi.up.railway.app/questions/json/all-posts/'
          // 'http://127.0.0.1:8000/questions/json/all-posts/'
          );
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Post
    List<Post> posts = [];
    for (var d in data) {
      if (d != null) {
        posts.insert(0, Post.fromJson(d));
      }
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const SizedBox(
            width: 500,
            height: 500,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color.fromARGB(255, 148, 209, 6)),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 250, 250, 250),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: FetchPosts(
                  scrollController: scrollController
                ),
                // child: FutureBuilder(
                //   future: fetchPosts(),
                //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                //     if (snapshot.data == null) {
                //       return const Center(child: CircularProgressIndicator());
                //     } else {
                //       if (!snapshot.hasData) {
                //         return Column(
                //           children: const [
                //             Text(
                //               "No posts yet...",
                //               style: TextStyle(
                //                   color: Color(0xff59A5D8), fontSize: 20),
                //             ),
                //             SizedBox(height: 8),
                //           ],
                //         );
                //       } else {
                //         return MediaQuery.removePadding(
                //           context: context,
                //           removeTop: true, 
                //           child: ListView.builder(
                //             itemCount: snapshot.data!.length,
                //             controller: scrollController,
                //             itemBuilder: (_, index) => Padding(
                //               padding: const EdgeInsets.fromLTRB(2, 2, 2, 0),
                //               child: Card(
                //                 margin: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(12),
                //                 ),
                //                 child: InkWell(
                //                   splashColor: Colors.blue.withAlpha(30),
                //                   customBorder: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(12)
                //                   ),
                //                   onTap: () {
                //                     Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                         builder: (context) => QuestionDetailPage(
                //                             post: snapshot.data[index]),
                //                       ),
                //                     );
                //                   },
                //                   child: SizedBox(
                //                     width: 300,
                //                     height: 150,
                //                     child: Column(
                //                       mainAxisAlignment: MainAxisAlignment.start,
                //                       crossAxisAlignment: CrossAxisAlignment.start,
                //                       children: [
                //                         Padding(
                //                           padding: const EdgeInsets.only(
                //                             left: 16, 
                //                             top: 10
                //                           ),
                //                           child: Row(
                //                             children: [
                //                               Text(
                //                                 snapshot.data![index].user_name,
                //                                 style: const TextStyle(
                //                                   fontSize: 14,
                //                                   color: Colors.black,
                //                                   fontWeight: FontWeight.w500,
                //                                 ),
                //                               ),
                //                               const SizedBox(
                //                                 width: 16,
                //                               ),
                //                               Text(
                //                                 '${snapshot.data![index].user_role}',
                //                                 style: const TextStyle(
                //                                   fontSize: 12,
                //                                   color: Color.fromARGB(255, 94, 91, 91),
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                         ListTile(
                //                           title: Text(
                //                             "${snapshot.data![index].title}",
                //                             style: const TextStyle(
                //                               fontSize: 18.0,
                //                               fontWeight: FontWeight.w500,
                //                             ),
                //                             overflow: TextOverflow.ellipsis,
                //                             maxLines: 1,
                //                           ),
                //                           subtitle: Text(
                //                             "${snapshot.data![index].body}",
                //                             // style: const TextStyle(
                //                             //   fontSize: 16.0,
                //                             // ),
                //                             maxLines: 3,
                //                             softWrap: false,
                //                             overflow: TextOverflow.ellipsis,
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           )
                //         );
                //       }
                //     }
                //   },
                // ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(251, 192, 45, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddQuestionForm(),
            ),
          ).then((_){
            // refresh the page after returning
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
