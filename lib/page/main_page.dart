import 'package:do_nasi/page/home_page.dart';
import 'package:do_nasi/page/page_overview.dart';
import 'package:do_nasi/page/profile.dart';
import 'package:do_nasi/page/questions.dart';
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
    const PageOverview(),
    const QuestionsPage(),
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
