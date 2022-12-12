import 'package:flutter/material.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          )
        ),
        backgroundColor: Colors.white,
        foregroundColor: Color.fromARGB(255, 191, 6, 6),
        shadowColor: Color.fromARGB(28, 113, 113, 105),
        elevation: 4,
      ),
      body: SingleChildScrollView(
            reverse: true,
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(top:16, left: 28, right: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul dan konten post
                  Center(
                    child: Text(
                      "Story Behind Do-Nasi",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600, 
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'Permasalahan terkait kesehatan global menjadi salah satu topik yang dibahas dalam G20. The G20 Health Working Group (HWG) membuat beberapa agenda internasional untuk memperkuat sistem kesehatan global salah satunya adalah dengan cara mengurangi jumlah malnutrisi. Do-nasi hadir sebagai sebuah aplikasi yang memberikan ruang untuk saling berbagi dan menyalurkan makanan atau uang untuk masyarakat yang membutuhkan. Perancangan aplikasi ini ditujukan untuk membantu mengurangi angka kelaparan dan malnutrisi secara bersama-sama. Pengguna dapat mendaftarkan diri sebagai pemberi donasi (donatur) ataupun penyalur donasi (sukarelawan). ',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}