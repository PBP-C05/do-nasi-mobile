import 'package:do_nasi/widgets/harapan_carousel.dart';
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
  String _namaUser = "";

  Future<List<HarapanModel>> fetchHarapan() async {
    var url =
        Uri.parse('https://do-nasi.up.railway.app/harapan-donatur/show-json/');

    //var url = Uri.parse("http://127.0.0.1:8000/harapan-donatur/show-json/");
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
    listHarapan.reversed;
    return listHarapan;
  }

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

  String _stringGetter(String input) {
    return input;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const MainPage()));
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
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
            child: SingleChildScrollView(
              child: Center(
                  child: Column(children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 4),
                  child: HarapanCarousel(),
                ),
                FutureBuilder(
                    future: request.get(
                        "https://do-nasi.up.railway.app/auth/get_user_json/"),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (!snapshot.hasData) {
                          return Column(
                            children: const [
                              Text(
                                "Silakan log in terlebih dahulu.",
                                style: TextStyle(
                                    color: Color(0xff59A5D8), fontSize: 20),
                              ),
                              SizedBox(height: 8),
                            ],
                          );
                        } else {
                          if (snapshot.data['data']['role'] == 'Donatur') {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Text(
                                'Hai ${snapshot.data['data']['name']}, Silakan lihat pesan dari Para Donatur!',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                        }
                      }
                    }),
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
              ])),
            ),
          ),
          FutureBuilder(
              future: request
                  .get("https://do-nasi.up.railway.app/auth/get_user_json/"),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return Column(
                      children: const [
                        Text(
                          "Silakan log in terlebih dahulu.",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    if (snapshot.data['data']['role'] == 'Donatur') {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 15,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue.shade900,
                                  radius: 25,
                                  // Colors.brown.shade800
                                  child: Material(
                                    shape: const CircleBorder(),
                                    clipBehavior: Clip.hardEdge,
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                      child: FutureBuilder(
                                          future: request.get(
                                              "https://do-nasi.up.railway.app/auth/get_user_json/"),
                                          //future: request
                                          //    .get("http://127.0.0.1:8000/auth/get_user_json/"),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.data == null) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else {
                                              if (!snapshot.hasData) {
                                                return Column(
                                                  children: const [
                                                    Text(
                                                      "Silakan log in terlebih dahulu.",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff59A5D8),
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(height: 8),
                                                  ],
                                                );
                                              } else {
                                                return InkWell(
                                                  onTap: (() {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return FutureBuilder(
                                                            future: request.get(
                                                                "https://do-nasi.up.railway.app/auth/get_user_json/"),
                                                            builder: (context,
                                                                AsyncSnapshot
                                                                    snapshot) {
                                                              if (snapshot
                                                                      .data ==
                                                                  null) {
                                                                return const Center(
                                                                    child:
                                                                        CircularProgressIndicator());
                                                              } else {
                                                                return AlertDialog(
                                                                  title: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .person,
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text(
                                                                          snapshot.data['data']
                                                                              [
                                                                              'name'],
                                                                          style:
                                                                              const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ))
                                                                    ],
                                                                  ),
                                                                  content: Text(
                                                                      'Anda merupakan donatur dengan username ${snapshot.data['data']['username']} dan email ${snapshot.data['data']['email']}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify),
                                                                );
                                                              }
                                                            });
                                                      },
                                                    );
                                                  }),
                                                  child: Text(
                                                    _stringSplitter((snapshot
                                                        .data['data']['name'])),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                );
                                              }
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    key: _harapanFormKey,
                                    child: FutureBuilder(
                                        future: request.get(
                                            "https://do-nasi.up.railway.app/auth/get_user_json/"),
                                        //future: request.get(
                                        //    "http://127.0.0.1:8000/auth/get_user_json/"),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.data == null) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else {
                                            if (!snapshot.hasData) {
                                              return Column(
                                                children: const [
                                                  Text(
                                                    "Silakan log in terlebih dahulu.",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff59A5D8),
                                                        fontSize: 20),
                                                  ),
                                                  SizedBox(height: 8),
                                                ],
                                              );
                                            } else {
                                              return TextFormField(
                                                style: const TextStyle(
                                                    fontSize: 12),
                                                decoration: InputDecoration(
                                                  
                                                    hintText:
                                                        ("Harapan dari ${snapshot.data['data']['username']} ....."),
                                                    // Menambahkan circular border agar lebih rapi
                                                    border: InputBorder.none),
                                                // Menambahkan behavior saat nama diketik
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _harapanText = value!;
                                                  });
                                                },
                                                // Menambahkan behavior saat data disimpan
                                                onSaved: (String? value) {
                                                  setState(() {
                                                    _harapanText = value!;
                                                  });
                                                },
                                                // Validator sebagai validasi form
                                                validator: (String? value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Harapan anda masih kosong !';
                                                  }
                                                  return null;
                                                },
                                              );
                                            }
                                          }
                                        }),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FutureBuilder(
                                  future: request.get(
                                      "https://do-nasi.up.railway.app/auth/get_user_json/"),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    return Material(
                                      shape: const CircleBorder(),
                                      clipBehavior: Clip.hardEdge,
                                      color: Colors.transparent,
                                      child: InkWell(
                                          onTap: () async {
                                            if (_harapanFormKey.currentState!
                                                .validate()) {
                                              const url =
                                                  "https://do-nasi.up.railway.app/harapan-donatur/add-harapan/";

                                              await request.postJson(
                                                url,
                                                convert.jsonEncode(
                                                    {"text": _harapanText}),
                                              );
                                              _harapanFormKey.currentState
                                                  ?.reset();
                                            }
                                            setState(() {});
                                          },
                                          hoverColor: const Color.fromARGB(
                                              0, 7, 168, 243),
                                          focusColor: const Color(0x000373fc),
                                          child: const Icon(
                                            Icons.send,
                                            size: 30,
                                            color: Color.fromARGB(
                                                255, 50, 132, 241),
                                          )),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Text('');
                    }
                  }
                }
              }),
        ],
      ),
    );
  }
}
