import 'package:do_nasi/views/dummy_counter.dart';
import 'package:do_nasi/views/home_page.dart';
import 'package:do_nasi/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blueGrey[50],
      ),
      home: const MainPage(title: 'Flutter App'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int navbarIndex = 0;
  final screens = [
    MyHomePage(),
    DummyPage(),
    // bakal ada page untuk profile
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
