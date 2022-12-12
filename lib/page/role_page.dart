// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

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
                      "Role Pengguna di Do-Nasi",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600, 
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Terdapat dua role pengguna aplikasi DoNasi, yaitu DONATUR dan PENYALUR",
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  // DONATUR
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "Donatur",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600, 
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/donatur.png'),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'Pengguna yang mendaftarkan dirinya sebagai donatur dapat menyumbangkan makanan/uang ke donasi yang dibuka oleh para penyalur.',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  // PENYALUR
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "Penyalur",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600, 
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/penyalur.png'),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'Pengguna yang mendaftarkan dirinya sebagai penyalur dapat membuka donasi baru untuk kemudian disalurkan ke orang-orang yang membutuhkan.',
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