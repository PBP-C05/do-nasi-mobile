import 'package:do_nasi/page/home_page.dart';
import 'package:do_nasi/page/page_overview.dart';
import 'package:do_nasi/page/profile.dart';
<<<<<<< HEAD
import 'package:do_nasi/page/article.dart';
=======
import 'package:do_nasi/page/questions.dart';
>>>>>>> 93cd048af4aaea6cb1f1fc7ce466cde0b0d92223
import 'package:do_nasi/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int navbarIndex = 0;
  final screens = [
    const MyHomePage(),
<<<<<<< HEAD
    const ArticlePage(), // Nanti ganti aja yg ini
    const HarapanPage(), // Sama ini
=======
    const PageOverview(),
    const QuestionsPage(),
>>>>>>> 93cd048af4aaea6cb1f1fc7ce466cde0b0d92223
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
      body: screens[navbarIndex],
      bottomNavigationBar: BottomNavBar(
        onTap: (value) => setState(() {
          navbarIndex = value;
        }),
      ),
    );
  }
}
