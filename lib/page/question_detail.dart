import 'package:do_nasi/model/comment.dart';
import 'package:do_nasi/model/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class QuestionDetailPage extends StatefulWidget {
  final Post post;
  const QuestionDetailPage({super.key, required this.post});

  @override
  State<QuestionDetailPage> createState() => _QuestionDetailPageState();
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  Future<List<Comment>> fetchComments(postPk) async {
    var url = Uri.parse(
        'https://do-nasi.up.railway.app/questions/json/all-comments/$postPk');
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Comment
    List<Comment> comments = [];
    for (var d in data) {
      if (d != null) {
        comments.add(Comment.fromJson(d));
      }
    }
    return comments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Button untuk kembali (might change this into an Appbar)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Color.fromARGB(255, 255, 193, 7),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // Judul dan konten post
            Center(
              child: Text(
                widget.post.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            Flexible(
              child: Text(widget.post.body),
            ),
            // Fetch comments
            FutureBuilder(
              future: fetchComments(widget.post.pk),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData || snapshot.data!.length == 0) {
                    return Column(
                      children: const [
                        Center(
                          child: Text(
                            "No comments yet...",
                            style: TextStyle(
                              color: Color(0xff59A5D8), 
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      // TAMPILAN UNTUK TILE COMMENT
                      itemBuilder: (_, index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        padding: const EdgeInsets.all(8.0),
                        // decoration: BoxDecoration(
                        //   color: Colors.white,
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   boxShadow: const [
                        //     BoxShadow(color: Colors.black, blurRadius: 2.0),
                        //   ],
                        // ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data![index].user_username}",
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              "${snapshot.data![index].body}",
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      )
    );
  }
}
