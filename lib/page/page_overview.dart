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
  @override
  void refresh() {
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Page Overview'),
        ),
        body: FutureBuilder(
          future: request.get("https://do-nasi.up.railway.app/auth/get_user_json/"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null){
              final is_penyalur = snapshot.data['data']['role'] == "Penyalur" ? true : false ;
              return FutureBuilder(
                  future: fetchPageOverview(request),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (!snapshot.hasData) {
                        return Column(
                          children: const [
                            Text(
                              "Tidak ada Page :(",
                              style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                            ),
                            SizedBox(height: 8),
                          ],
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) {
                              if (index == snapshot.data!.length - 1 && is_penyalur) {
                                return Column(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(15.0),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 2.0)
                                            ]),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Title:",
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
                                                "Description:",
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
                                              "Deadline:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Flexible(
                                                child: Text(
                                                    DateFormat('EEEE, MMM d, yyyy')
                                                        .format(snapshot.data![index]
                                                        .fields.deadline)))
                                          ]),
                                        ])),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.yellow[900], // Background color
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MyFormPage(setparent: refresh)));
                                        },
                                        child: const Text('TAMBAH DONASI'))
                                  ],
                                );
                              }
                              return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 2.0)
                                      ]),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Title ",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Flexible(
                                            child: Text(
                                                snapshot.data![index].fields.title))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Description ",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Flexible(
                                            child: Text(snapshot
                                                .data![index].fields.description))
                                      ],
                                    ),
                                    Row(children: [
                                      const Text(
                                        "Deadline ",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                          child: Text(DateFormat('EEEE, MMM d, yyyy')
                                              .format(snapshot
                                              .data![index].fields.deadline)))
                                    ]),
                                  ]));
                            });
                      }
                    }
                  });
            }
            else{
              return const Center(child: CircularProgressIndicator());
            }
          } ,
        ));
  }
}
