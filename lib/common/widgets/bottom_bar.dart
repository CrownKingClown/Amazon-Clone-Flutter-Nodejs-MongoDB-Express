import 'package:amazonclone/constants/global_variables.dart';
import 'package:amazonclone/features/account/screens/account_screend.dart';
import 'package:amazonclone/features/home/screens/home_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  static const routeName = '/actualHome';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 50.0;
  double bottomBarBorderWidth = 5.0;
  List<Widget> pages = [
    const HomeScreen(),
    const Center(child: Text('Cart')),
    const AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: [
          // Home
          BottomNavigationBarItem(
            label: 'Home',
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: bottomBarBorderWidth,
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(Icons.home),
            ),
          ),
          // Profile
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: bottomBarBorderWidth,
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(Icons.person_outline_outlined),
            ),
          ),
          // Cart
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: bottomBarBorderWidth,
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: Badge(
                  elevation: 0,
                  badgeColor: Colors.white,
                  badgeContent: const Text(
                    '1',
                    style: TextStyle(color: Colors.black),
                  ),
                  child: const Icon(Icons.shopping_cart_outlined)),
            ),
          ),
        ],
        onTap: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
