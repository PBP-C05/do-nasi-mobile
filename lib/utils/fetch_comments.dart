import 'package:do_nasi/model/comment.dart';
import 'package:do_nasi/model/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class FetchComments extends StatefulWidget {
  const FetchComments({super.key, required this.post});

  final Post post;

  @override
  State<FetchComments> createState() => _FetchCommentsState();
}

class _FetchCommentsState extends State<FetchComments> {
  Future<List<Comment>> fetchComments(postPk) async {
    var url = Uri.parse(
        'https://do-nasi.up.railway.app/questions/json/all-comments/$postPk'
        // 'http://127.0.0.1:8000/questions/json/all-comments/$postPk'
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
    return FutureBuilder(
      future: fetchComments(widget.post.pk),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (!snapshot.hasData || snapshot.data!.length == 0) {
            return Column(
              children: const [
                SizedBox(height: 8),
                Center(
                  child: Text(
                    "No comments yet...",
                    style: TextStyle( 
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              // TAMPILAN UNTUK TILE COMMENT
              itemBuilder: (_, index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(183, 255, 255, 255),
                  border: Border.all(
                    color: Color.fromARGB(183, 113, 108, 108),
                    width: 0.2
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 54, 60, 244),
                          radius: 12,
                          child: Text(
                            snapshot.data![index].user_name.substring(0,1),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(width: 8), //spacing
                        Text(
                          "${snapshot.data![index].user_name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${snapshot.data![index].body}",
                      // style: const TextStyle(
                      //   fontSize: 16.0,
                      // ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
