import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

class HarapanComments extends StatefulWidget {
  const HarapanComments({super.key});

  @override
  State<HarapanComments> createState() => _HarapanCommentsState();
}

class _HarapanCommentsState extends State<HarapanComments> {
  final _harapanFormKey = GlobalKey<FormState>();
  String _harapanText = "";

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
    return FutureBuilder(
        future:
            request.get("https://do-nasi.up.railway.app/auth/get_user_json/"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return Column(
                children: const [
                  Text(
                    "Silakan log in terlebih dahulu.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
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
                                          return InkWell(
                                            onTap: (() {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return FutureBuilder(
                                                      future: request.get(
                                                          "https://do-nasi.up.railway.app/auth/get_user_json/"),
                                                      builder: (context,
                                                          AsyncSnapshot
                                                              snapshot) {
                                                        if (snapshot.data ==
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
                                                                  Icons.person,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 24.0,
                                                                ),
                                                                const SizedBox(
                                                                    width: 5),
                                                                Text(
                                                                    snapshot.data[
                                                                            'data']
                                                                        [
                                                                        'name'],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ))
                                                              ],
                                                            ),
                                                            content: Text(
                                                                'Anda merupakan donatur dengan username ${snapshot.data['data']['username']} dan email ${snapshot.data['data']['email']}',
                                                                style:
                                                                    const TextStyle(
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
                                        return TextFormField(
                                          style: const TextStyle(fontSize: 12),
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
                                              return null;
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
                                        _harapanFormKey.currentState?.reset();
                                      }
                                      setState(() {});
                                    },
                                    hoverColor:
                                        const Color.fromARGB(0, 7, 168, 243),
                                    focusColor: const Color(0x000373fc),
                                    child: const Icon(
                                      Icons.send,
                                      size: 30,
                                      color: Color.fromARGB(255, 50, 132, 241),
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
        });
  }
}
