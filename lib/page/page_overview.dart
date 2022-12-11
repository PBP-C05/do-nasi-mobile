import 'dart:async';

import 'package:date_count_down/countdown.dart';
import 'package:do_nasi/model/page_overview_model.dart';
import 'package:do_nasi/utils/page_overview_utils.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:do_nasi/page/page_overview_form.dart';

class PageOverview extends StatefulWidget {
  const PageOverview({super.key});

  @override
  State<PageOverview> createState() => _PageOverviewState();
}

class _PageOverviewState extends State<PageOverview> {
  String countdown = "Loading...";
  late Timer _timer;

  @override
  void initState(){
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose(){
    super.dispose();
    _timer.cancel();
  }

  @override
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[400],
          centerTitle: true,
          title: const Text('Page Overview'),
        ),
        body: FutureBuilder(
          future: request.get("https://do-nasi.up.railway.app/auth/get_user_json/"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              final is_penyalur =
                  snapshot.data['data']['role'] == "Penyalur" ? true : false;
              return FutureBuilder(
                  future: fetchPageOverview(request),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    else {
                      if (!snapshot.hasData) {
                        return Column(
                          children: const [
                            Text(
                              "Tidak ada Page :(",
                              style: TextStyle(
                                  color: Color(0xff59A5D8), fontSize: 20),
                            ),
                            SizedBox(height: 8),
                          ],
                        );
                      }
                      else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) {
                              if (index == snapshot.data!.length - 1 && is_penyalur) {
                                return Column(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                        padding: const EdgeInsets.all(32.0),
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.0), boxShadow: const [BoxShadow(color: Colors.yellow, blurRadius: 2.0)]),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Title                  :",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Flexible(
                                                  child: Text(snapshot
                                                      .data![index].fields.title))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Description :",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Flexible(
                                                  child: Text(snapshot.data![index]
                                                      .fields.description))
                                            ],
                                          ),
                                          Row(children: [
                                            const Text(
                                              "Deadline       :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Flexible(
                                                child: Text(CountDown().timeLeft(DateTime.parse(snapshot.data![index].fields.deadline.toString()), " Expired", " Days ", " Hours ", " Minutes ", " Seconds ", " Days ", " Hours ", " Minutes ", " Seconds ")))
                                          ]),
                                        ])),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.yellow[400], // Background color
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyFormPage(
                                                          setparent: refresh)));
                                        },
                                        child: const Text('TAMBAH DONASI'))],
                                );
                              }
                              else if (is_penyalur) {
                                return Column(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 12),
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.yellow,
                                                  blurRadius: 2.0)
                                            ]),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Title                  :",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Flexible(
                                                  child: Text(snapshot
                                                      .data![index].fields.title))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Description :",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Flexible(
                                                  child: Text(snapshot.data![index]
                                                      .fields.description))
                                            ],
                                          ),
                                          Row(children: [
                                            const Text(
                                              "Deadline       :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Flexible(
                                                child: Text(CountDown().timeLeft(DateTime.parse(snapshot.data![index].fields.deadline.toString()), " Expired", " Days ", " Hours ", " Minutes ", " Seconds ", " Days ", " Hours ", " Minutes ", " Seconds ")))
                                          ]),
                                        ])),
                                  ],
                                );
                              }
                                else if (DateTime.parse(snapshot
                                          .data![index].fields.deadline
                                          .toString())
                                      .isAfter(DateTime.parse(
                                          DateTime.now().toString())) &&
                                  !is_penyalur) {
                                return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    padding: const EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.yellow,
                                              blurRadius: 2.0)
                                        ]),
                                    child: Column(children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Title                  :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Flexible(
                                              child: Text(snapshot
                                                  .data![index].fields.title))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Description :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Flexible(
                                              child: Text(snapshot.data![index]
                                                  .fields.description))
                                        ],
                                      ),
                                      Row(children: [
                                        Text(
                                          "Deadline       :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Flexible(
                                            child: Text(CountDown().timeLeft(DateTime.parse(snapshot.data![index].fields.deadline.toString()), " Expired"," Days ", " Hours ", " Minutes ", " Seconds ", " Days ", " Hours ", " Minutes ", " Seconds ")))
                                      ]),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.yellow[400]),
                                              ),
                                              onPressed: () async {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        insetPadding: const EdgeInsets.all(10),
                                                        elevation: 15,
                                                        child: ListView(
                                                          padding:
                                                          const EdgeInsets.only(top: 20, bottom: 20, left: 40, right: 40),
                                                          shrinkWrap: true,
                                                          children: const <Widget>[
                                                            Center(
                                                                child: Text('BERHASIl MELAKUKAN DONASI')),],
                                                        ),
                                                      );
                                                    },
                                                  );
                                              },
                                              child: const Text(
                                                "MELAKUKAN DONASI",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ),
                                      ]),
                                    ]));
                              }
                                else {
                                return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    padding: const EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.yellow,
                                              blurRadius: 2.0)
                                        ]),
                                    child: Column(children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Title                  :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Flexible(
                                              child: Text(snapshot
                                                  .data![index].fields.title))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Description :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Flexible(
                                              child: Text(snapshot.data![index]
                                                  .fields.description))
                                        ],
                                      ),
                                      Row(children: [
                                        const Text(
                                          "Deadline       :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Flexible(
                                            child: Text(CountDown().timeLeft(DateTime.parse(snapshot.data![index].fields.deadline.toString()), " Expired", " Days ", " Hours ", " Minutes ", " Seconds ", " Days ", " Hours ", " Minutes ", " Seconds ")))
                                      ]),
                                    ]));
                              }
                            });
                      }
                    }
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
