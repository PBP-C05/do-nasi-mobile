import 'package:do_nasi/page/article_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:do_nasi/model/article.dart';
import 'package:do_nasi/page/article_detail.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

// class HtmlTags {
//   static removeTag({htmlString, callback}) {
//     var document = parse(htmlString);
//     var parsedString = parse(document.body?.text).documentElement?.text;
//     callback(parsedString);
//   }
// }

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<ArticlePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ArticlePage> {
  Future<List<Article>> fetchArticle() async {
    var url = Uri.parse('https://do-nasi.up.railway.app/article/json/article');
    // var url = Uri.parse("http://10.0.2.2:8000/article/json/article");
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Article
    List<Article> article = [];
    for (var d in data) {
      if (d != null) {
        article.add(Article.fromJson(d));
      }
    }

    return article;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       opacity: 0.5,
        //       image: AssetImage('assets/images/article_image.png'),
        //       fit: BoxFit.cover),
        // ),
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

            // horizontal).
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 150,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         opacity: 0.5,
                //         image:
                //             AssetImage("assets/images/article_image.png"),
                //         fit: BoxFit.cover)),
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Text("Tambahkan Artikelmu Disini",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            )),
                        height: 30,
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 115.0, right: 115.0, top: 40),
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(255, 205, 46, 1)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyFormPage()));
                            },
                            child: Text(
                              'Tambahkan Artikel',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
              SizedBox(
                height: 0,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    )),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: FutureBuilder(
                    future: fetchArticle(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (!snapshot.hasData) {
                          return Column(
                            children: const [
                              Text(
                                "Belum ada artikel :(",
                                style: TextStyle(
                                    color: Color(0xff59A5D8), fontSize: 20),
                              ),
                              SizedBox(height: 8),
                            ],
                          );
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) => GestureDetector(
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ArticleDetailPage(
                                                pk: snapshot.data![index].pk,
                                                username: snapshot.data![index]
                                                    .fields.user.username
                                                    .toString(),
                                                date: snapshot
                                                    .data![index].fields.date
                                                    .toString(),
                                                title: snapshot
                                                    .data![index].fields.title,
                                                body: snapshot
                                                    .data![index].fields.body
                                                    .replaceAll(
                                                        RegExp(
                                                            r'<[^>]*>|&[^;]+;'),
                                                        ''),
                                                slug: snapshot
                                                    .data![index].fields.slug)),
                                      ),
                                  child: SizedBox(
                                      height: 110,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 10),
                                        padding: const EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color: Color.fromRGBO(
                                                  200, 200, 200, 1),
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 99, 99, 99),
                                                  offset: Offset(1, 1))
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${snapshot.data![index].fields.title}",
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            // ignore: avoid_print

                                            const SizedBox(height: 5),
                                          ],
                                        ),
                                      ))));
                        }
                      }
                    }),
                //   decoration: BoxDecoration(
                //       color: Color.fromARGB(1, 255, 255, 255),
                //       borderRadius: BorderRadius.only(
                //           topRight: Radius.circular(30.0),
                //           topLeft: Radius.circular(30.0))),
              ))
            ]),
      ),
    )); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
