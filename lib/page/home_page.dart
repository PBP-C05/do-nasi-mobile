import 'package:do_nasi/page/harapan_page.dart';
import 'package:do_nasi/page/page_overview.dart';
import 'package:do_nasi/page/questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: 420,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 222, 197, 4)
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 0.89,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 250, 250, 250),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow[900], // Background color
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HarapanPage(),
                                  ),
                                );
                              },
                              child: const Text('HaraPage'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow[900], // Background color
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const QuestionsPage(),
                                  ),
                                );
                              },
                              child: const Text('QnA Page'),
                            ),
                          ),
                          // BUAT ARTICLE PAGE
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow[900], // Background color
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    // NANTI GANTI: ARTICLE PAGE
                                    builder: (context) => const QuestionsPage(),
                                  ),
                                );
                              },
                              child: const Text('ArtiPage'),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 220,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              margin: const EdgeInsets.fromLTRB(20, 4, 2, 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {},
                                child: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        height: 150,
                                        child: Image.asset(
                                          'assets/images/WorldHunger.jpg',
                                          fit: BoxFit.fill,
                                        )
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: Text("Story Behind do-nasi"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              margin: const EdgeInsets.fromLTRB(20, 4, 2, 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {},
                                child: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        height: 150,
                                        child: Image.asset(
                                          'assets/images/WorldHunger.jpg',
                                          fit: BoxFit.fill,
                                        )
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: Text("Role Do-nasi"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialog(
                                        title: Text(
                                          'The Story Behind do-nasi',
                                          style: TextStyle(fontWeight: FontWeight.w700),
                                        ),
                                        content: Text(
                                          'Permasalahan terkait kesehatan global menjadi salah satu topik yang dibahas dalam G20. The G20 Health Working Group (HWG) membuat beberapa agenda internasional untuk memperkuat sistem kesehatan global salah satunya adalah dengan cara mengurangi jumlah malnutrisi. Do-nasi hadir sebagai sebuah aplikasi yang memberikan ruang untuk saling berbagi dan menyalurkan makanan atau uang untuk masyarakat yang membutuhkan. Perancangan aplikasi ini ditujukan untuk membantu mengurangi angka kelaparan dan malnutrisi secara bersama-sama. Pengguna dapat mendaftarkan diri sebagai pemberi donasi (donatur) ataupun penyalur donasi (sukarelawan). ',
                                          style: TextStyle(fontSize: 12),
                                          textAlign: TextAlign.justify,
                                        ),
                                      );
                                    },
                                  )
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(0, 2),
                                        )
                                      ],
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(20))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('The Story Behind do-nasi',
                                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 25.0,
                                                      height: 25.0,
                                                      decoration: const BoxDecoration(
                                                          //shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: AssetImage(
                                                                  'assets/images/donatur.png')))),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    'Penyalur',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              content: const Text(
                                                  'Pengguna yang mendaftarkan dirinya sebagai penyalur dapat membuka donasi baru untuk kemudian disalurkan ke orang-orang yang membutuhkan.',
                                                  style: TextStyle(fontSize: 12),
                                                  textAlign: TextAlign.justify),
                                            );
                                          },
                                        )
                                      },
                                      child: Container(
                                        height: 120.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: const Offset(0, 2),
                                              )
                                            ],
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: const BoxDecoration(
                                                    //shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: AssetImage(
                                                            'assets/images/donatur.png')))),
                                            const Text('Penyalur',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 25.0,
                                                      height: 25.0,
                                                      decoration: const BoxDecoration(
                                                          //shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: AssetImage(
                                                                  'assets/images/donatur.png')))),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    'Donatur',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              content: const Text(
                                                  'Pengguna yang mendaftarkan dirinya sebagai donatur dapat menyumbangkan makanan/uang ke donasi yang dibuka oleh para penyalur.',
                                                  style: TextStyle(fontSize: 12),
                                                  textAlign: TextAlign.justify),
                                            );
                                          },
                                        )
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width / 2,
                                        height: 120.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: const Offset(0, 2),
                                              )
                                            ],
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: const BoxDecoration(
                                                    //shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: AssetImage(
                                                            'assets/images/penyalur.png')))),
                                            const Text('Donatur',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
