import 'package:do_nasi/page/dummy_counter.dart';
import 'package:do_nasi/page/home_page.dart';
import 'package:do_nasi/page/profile.dart';
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
    MyHomePage(),
    DummyPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: screens[navbarIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: navbarIndex,
        onTap: (value) => setState(() => navbarIndex = value),
      ),
    );
  }
}