import 'package:do_nasi/utils/fetch_harapan.dart';
import 'package:do_nasi/widgets/harapan_carousel.dart';
import 'package:do_nasi/widgets/harapan_comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

import '../model/harapan.dart';
import 'home_page.dart';
import 'main_page.dart';

class HarapanPage extends StatefulWidget {
  const HarapanPage({super.key});

  @override
  State<HarapanPage> createState() => _HarapanPageState();
}

class _HarapanPageState extends State<HarapanPage> {
  final _harapanFormKey = GlobalKey<FormState>();
  String _harapanText = "";
<<<<<<< HEAD
  String _namaUser = "";

  Future<List<HarapanModel>> fetchHarapan() async {
    var url =
        Uri.parse('https://do-nasi.up.railway.app/harapan-donatur/show-json/');

    // var url = Uri.parse("http://127.0.0.1:8000/harapan-donatur/show-json/");
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object MyWatchList
    List<HarapanModel> listHarapan = [];
    for (var d in data) {
      if (d != null) {
        listHarapan.add(HarapanModel.fromJson(d['fields']));
      }
    }

    return listHarapan;
  }
=======
>>>>>>> 93cd048af4aaea6cb1f1fc7ce466cde0b0d92223

  String _stringSplitter(String input) {
    String result = "";
    final splitted = input.split(' ');
    if (splitted.length == 1) {
      result = splitted[0].substring(0, 1);
    } else {
      result = splitted[0].substring(0, 1) + splitted[1].substring(0, 1);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/icon.ico', fit: BoxFit.cover),
                Image.asset('assets/images/logo.png', fit: BoxFit.cover),
              ],
            ),
            SizedBox(width: MediaQuery.of(context).size.width / 6)
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
<<<<<<< HEAD
            child: SingleChildScrollView(
              child: Center(
                  child: Column(children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 4),
                  child: HarapanCarousel(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                      future: fetchHarapan(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          if (!snapshot.hasData) {
                            return Column(
                              children: const [
                                Text(
                                  "Tidak ada harapan :(",
                                  style: TextStyle(
                                      color: Color(0xff59A5D8), fontSize: 20),
                                ),
                                SizedBox(height: 8),
                              ],
                            );
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 2, 2, 0),
                                  child: Card(
                                      child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].username,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${snapshot.data![index].email}',
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Color.fromARGB(
                                                  255, 94, 91, 91),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Flexible(
                                          child: Text(
                                            snapshot.data![index].text,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            DateFormat.yMMMMd().format(
                                                DateTime.parse(snapshot
                                                    .data![index].createdAt)),
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Color.fromARGB(
                                                  255, 69, 68, 68),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])),
                                );
                              },
                              padding: const EdgeInsets.only(bottom: 8.0),
                            );
                          }
                        }
                      }),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[900], // Background color
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()));
                    },
                    child: const Text('Back')),
              ])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 15,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.shade900,
                      // Colors.brown.shade800
                      child: FutureBuilder(
                          future: request.get(
                              "https://do-nasi.up.railway.app/auth/get_user_json/"),
                          // future: request
                          //     .get("http://127.0.0.1:8000/auth/get_user_json/"),
=======
            child: DraggableScrollableSheet(
                initialChildSize: 1,
                minChildSize: 1,
                maxChildSize: 1,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return SingleChildScrollView(
                    child: Center(
                        child: Column(children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 4),
                        child: HarapanCarousel(),
                      ),
                      FutureBuilder(
                          future: request.get(
                              "https://do-nasi.up.railway.app/auth/get_user_json/"),
>>>>>>> 93cd048af4aaea6cb1f1fc7ce466cde0b0d92223
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              if (!snapshot.hasData) {
                                return Column(
                                  children: const [
                                    Text(
                                      "Silakan log in terlebih dahulu.",
                                      style: TextStyle(
                                          color: Color(0xff59A5D8),
                                          fontSize: 20),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                );
                              } else {
<<<<<<< HEAD
                                return InkWell(
                                  //Show Dialog Profile Nanti...
                                  child: Text(_stringSplitter(
                                      (snapshot.data['data']['name']))),
                                );
                              }
                            }
                          }),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: FutureBuilder(
                            future: request.get(
                                "https://do-nasi.up.railway.app/auth/get_user_json/"),
                            // future: request.get(
                            //     "http://127.0.0.1:8000/auth/get_user_json/"),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                if (!snapshot.hasData) {
                                  return Column(
                                    children: const [
                                      Text(
                                        "Silakan log in terlebih dahulu.",
                                        style: TextStyle(
                                            color: Color(0xff59A5D8),
                                            fontSize: 20),
                                      ),
                                      SizedBox(height: 8),
                                    ],
=======
                                if (snapshot.data['data']['role'] ==
                                    'Donatur') {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 15, 0),
                                          child: Text(
                                            'Apakah anda tertarik mengisi harapan, ${snapshot.data['data']['name']} ?',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
>>>>>>> 93cd048af4aaea6cb1f1fc7ce466cde0b0d92223
                                  );
                                } else {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: Text(
                                      'Hai ${snapshot.data['data']['name']}, Silakan lihat pesan dari Para Donatur!',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                              }
<<<<<<< HEAD
                            }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: request.get(
                          "https://do-nasi.up.railway.app/auth/get_user_json/"),
                      // future: request
                      //     .get("http://127.0.0.1:8000/auth/get_user_json/"),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                //const url =
                                //    "https://do-nasi.up.railway.app/harapan-donatur/show-json/";
                                const url =
                                    "http://127.0.0.1:8000/harapan-donatur/show-json/";

                                await request.post(url, {
                                  "user": snapshot.data['data']['user'],
                                  "username": snapshot.data['data']['username'],
                                  "email": DateTime.now(),
                                  "created_at": snapshot.data['data']
                                      ['created_at'],
                                  "text": _harapanText,
                                });
                                print(url);
                              }
                            },
                            hoverColor: const Color.fromARGB(0, 7, 168, 243),
                            focusColor: const Color(0x000373fc),
                            child: const Icon(
                              Icons.send,
                              size: 30,
                              color: Color.fromARGB(255, 50, 132, 241),
                            ));
                      },
                    ),
                  )
                ],
              ),
            ),
          )
=======
                            }
                          }),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              FetchHarapan(scrollController: scrollController)),
                    ])),
                  );
                }),
          ),
          const HarapanComments()
>>>>>>> 93cd048af4aaea6cb1f1fc7ce466cde0b0d92223
        ],
      ),
    );
  }
}
