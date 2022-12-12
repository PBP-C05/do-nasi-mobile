import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../model/harapan.dart';

class FetchHarapan extends StatefulWidget {
  const FetchHarapan({super.key, required this.scrollController});

  final ScrollController scrollController;
  @override
  State<FetchHarapan> createState() => _FetchHarapanState();
}

class _FetchHarapanState extends State<FetchHarapan> {
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchHarapan(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return Column(
                children: const [
                  Text(
                    "Tidak ada harapan :(",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                controller: widget.scrollController,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 0),
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                          child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
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
                    ),
                  );
                },
                padding: const EdgeInsets.only(bottom: 8.0),
              );
            }
          }
        });
  }
}
