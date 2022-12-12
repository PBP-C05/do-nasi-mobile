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
        ],
      ),
    );
  }
}
