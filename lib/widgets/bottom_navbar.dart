import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, 
    this.selectedIndex = 0, 
    required this.onTap,
  });

  final int selectedIndex;
  final void Function(int) onTap;

 @override
  Widget build(BuildContext context) {
    return Container(
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
          selectedIndex: selectedIndex,
          onTabChange: onTap,
          rippleColor: Colors.black54, // tab button ripple color when pressed
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
          tabBackgroundColor:
              const Color.fromRGBO(251, 192, 45, 1), // selected tab background color
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
          ],
        ),
      ),
    );
  }
}
