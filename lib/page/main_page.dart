import 'package:do_nasi/page/dummy_counter.dart';
import 'package:do_nasi/page/harapan_page.dart';
import 'package:do_nasi/page/home_page.dart';
import 'package:do_nasi/page/profile.dart';
import 'package:do_nasi/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int navbarIndex = 0;
  final screens = [
    const MyHomePage(),
    const DummyPage(), // Nanti ganti aja yg ini
    const HarapanPage(), // Sama ini
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GNav(
                selectedIndex: navbarIndex,
                onTabChange: (index) {
                  setState(() {
                    navbarIndex = index;
                  });
                },
                rippleColor:
                    Colors.black54, // tab button ripple color when pressed
                hoverColor: Colors.yellow, // tab button hover color
                haptic: true, // haptic feedback
                tabBorderRadius: 10,
                curve: Curves.linear, // tab animation curves
                duration:
                    const Duration(milliseconds: 300), // tab animation duration
                gap: 8, // the tab button gap between icon and text
                color: Colors.yellow[700], // unselected icon color
                activeColor: Colors.white, // selected icon and text color
                iconSize: 24, // tab button icon size
                tabBackgroundColor: const Color.fromRGBO(
                    251, 192, 45, 1), // selected tab background color
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 5), // navigation bar padding
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: 'Likes',
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  )
                ]),
          ),
        ));
  }
}
