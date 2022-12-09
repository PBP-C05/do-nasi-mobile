import 'package:do_nasi/widgets/harapan_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import '../model/harapan.dart';

class HarapanPage extends StatefulWidget {
  const HarapanPage({super.key});

  @override
  State<HarapanPage> createState() => _HarapanPageState();
}

class _HarapanPageState extends State<HarapanPage> {
  Future<List<HarapanModel>> fetchHarapan() async {
    var url =
        Uri.parse('https://do-nasi.up.railway.app/harapan-donatur/show-json/');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/icon.ico', fit: BoxFit.cover),
            Image.asset('assets/images/logo.png', fit: BoxFit.cover),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(children: [
          const HarapanCarousel(),
          const Padding(
            padding: EdgeInsets.all(2.0),
            child: Text(
              'Apakah anda tertarik mengisi harapan ?',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          FutureBuilder(
              future: fetchHarapan(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return Column(
                      children: const [
                        Text(
                          "Tidak ada My Watch List :(",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
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
                          padding: const EdgeInsets.fromLTRB(2, 2, 2, 0),
                          child: Card(
                              child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                      color: Color.fromARGB(255, 94, 91, 91),
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
                                      fontSize: 15,
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
                                    DateFormat.yMMMMd().format(DateTime.parse(
                                        snapshot.data![index].createdAt)),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color.fromARGB(255, 69, 68, 68),
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
              })
        ])),
      ),
    );
  }
}
