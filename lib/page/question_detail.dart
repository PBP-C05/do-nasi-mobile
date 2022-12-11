import 'package:do_nasi/model/post.dart';
import 'package:do_nasi/utils/fetch_comments.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class QuestionDetailPage extends StatefulWidget {
  final Post post;
  const QuestionDetailPage({super.key, required this.post});

  @override
  State<QuestionDetailPage> createState() => _QuestionDetailPageState();
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  final _commentFormKey = GlobalKey<FormState>();
  String inputBody = "";
  final _controllerBody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Post"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          )
        ),
        backgroundColor: Colors.white,
        foregroundColor: Color.fromARGB(255, 135, 191, 6),
        shadowColor: Color.fromARGB(28, 113, 113, 105),
        elevation: 4,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            reverse: true,
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(top:16, left: 28, right: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul dan konten post
                  Center(
                    child: Text(
                      widget.post.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600, 
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.post.body,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  // Poster's account information
                  const SizedBox(height: 16), //spacing
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 14,
                        child: Text(
                          widget.post.user_name.substring(0,1),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 8), //spacing
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.user_name,
                          ),
                          Text(
                            widget.post.date,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Fetch comments
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 2),
                    child: Text(
                      "Comments:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  FetchComments(post: widget.post),
                  const SizedBox(height: 80), // offset buat textfield
                ],
              ),
            ),
          ),
          // COMMENT FORM
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: 360,
                child: Form(
                  key: _commentFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _controllerBody,
                      // DECORATION
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Comment...",
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        // SUBMIT BUTTON
                        suffixIcon: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 215, 166, 30),
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            if (_commentFormKey.currentState!.validate()) {
                              _commentFormKey.currentState!.save();
                              var url =
                                  'https://do-nasi.up.railway.app/questions/add-comment/${widget.post.pk}';
                              // 'http://127.0.0.1:8000/questions/add-comment/${widget.post.pk}';
                              final response = await request.post(url, {'body': inputBody});
                              // refresh
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      // DECORATION ON TYPE
                      onChanged: (String? value) {
                        setState(() {
                          inputBody = value!;
                        });
                      },
                      // VALIDATOR
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Tidak bisa mengirim komentar kosong";
                        }
                        return null;
                      },
                      // BEHAVIOUR ON STORING DATA
                      onSaved: (String? value) {
                        setState(() {
                          inputBody = value!;
                        });
                        _controllerBody.clear();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
