import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:do_nasi/model/comment_article.dart';
import 'dart:convert';
import 'package:do_nasi/model/article.dart';
import 'package:do_nasi/main.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ArticleDetailPage extends StatefulWidget {
  const ArticleDetailPage(
      {Key? key,
      required this.pk,
      required this.username,
      required this.date,
      required this.title,
      required this.body,
      required this.slug})
      : super(key: key);
  final String username;
  final String date;
  final String title;
  final String body;
  final String slug;
  final int pk;

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final _formKey = GlobalKey<FormState>();
  String body = "";
  Future<List<Comments>> fetchComments() async {
    var url = Uri.parse("https://do-nasi.up.railway.app/article/json/comments");
    // var url = Uri.parse("http://10.0.2.2:8000/article/json/comments");
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
    List<Comments> comments = [];
    for (var d in data) {
      if (d != null && d["fields"]["post"]["pk"] == widget.pk) {
        comments.add(Comments.fromJson(d));
      }
    }
    return (comments);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(title: const Text('Detail')),
        body: SingleChildScrollView(
            // child: SizedBox(
            //     height: MediaQuery.of(context).size.height,
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 35),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Posted on ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          widget.date.split(" ")[0],
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " by ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          widget.username,
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          widget.body,
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Text(
                          "Komentar",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Form(
                        key: _formKey,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Tuliskan Komentarmu",
                            labelText: "Komentar",
                            // Menambahkan icon agar lebih intuitif
                            // Menambahkan circular border agar lebih rapi
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          // Menambahkan behavior saat nama diketik
                          onChanged: (String? value) {
                            setState(() {
                              body = value!;
                            });
                          },
                          // Menambahkan behavior saat data disimpan
                          onSaved: (String? value) {
                            setState(() {
                              body = value!;
                            });
                          },
                          // Validator sebagai validasi form
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Komentar tidak boleh kosong!';
                            }
                            return null;
                          },
                        )),
                    Row(children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(255, 205, 46, 1)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            try {
                              var url =
                                  "https://do-nasi.up.railway.app/article/add_comment/${widget.slug}";
                              // var url =
                              //     "https://do-nasi.up.railway.app/article/json/comments";
                              final response =
                                  await request.post(url, {'body': body});
                            } catch (e) {}

                            // if (response['status'] == 'success') {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //           content: Text(
                            //               "Artikel telah berhasil dipublikasikan")));
                            //   Navigator.pop(context);
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(content: Text("Coba lagi")));
                            // }
                          }
                        },
                        child: Text('Kirim'),
                      ),
                    ]),
                    FutureBuilder(
                        future: fetchComments(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            if (!snapshot.hasData ||
                                snapshot.data!.length == 0) {
                              return Column(
                                children: const [
                                  Text(
                                    "\n Belum ada komentar",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 20),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              );
                            } else {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (_, index) => SizedBox(
                                      height: 100,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 5),
                                        padding: const EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            border: Border.all(
                                              color: Color.fromRGBO(
                                                  200, 200, 200, 1),
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 199, 199, 199),
                                                  offset: Offset(0.0, 1))
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${snapshot.data![index].fields.name.name}",
                                                style: const TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Text(
                                                    "${snapshot.data![index].fields.body}"
                                                        .replaceAll(
                                                            RegExp(
                                                                r'<[^>]*>|&[^;]+;'),
                                                            ''),
                                                    overflow: TextOverflow.fade,
                                                    // "${snapshot.data![index].fields.body}",
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                    ))),
                                            const SizedBox(height: 5),
                                          ],
                                        ),
                                      )));
                            }
                          }
                        }),
                    const SizedBox(
                      height: 320,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Back'),
                          ),
                        )
                      ]),
                    )
                  ],
                ))));
  }
}
