import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/features/acount/screens/account_screen.dart';
import 'package:ecommerce_app/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});
  static const String routeName = "/actual-home";

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomNavBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const AccountScreen()
  ]; 

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 29,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth),
                ),
              ),
              child: const badges.Badge(
                badgeStyle: badges.BadgeStyle(
                  elevation: 0,
                  badgeColor: Colors.white,
                ),
                badgeContent: Text("3"),
                child: Icon(Icons.home_outlined),
              ),
            ),
            label: '',
          ),
          //Profile
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth),
                ),
              ),
              child: const badges.Badge(
                badgeStyle: badges.BadgeStyle(
                  elevation: 0,
                  badgeColor: Colors.white,
                ),
                badgeContent: Text("3"),
                child: Icon(Icons.person_outline_outlined),
              ),
            ),
            label: '',
          ),
          //Cart
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 2
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth),
                ),
              ),
              child: const badges.Badge(
                badgeAnimation: badges.BadgeAnimation.slide(),
                badgeStyle: badges.BadgeStyle(
                  elevation: 0,
                  badgeColor: Colors.white,
                ),
                badgeContent: Text("3"),
                child: Icon(Icons.shopping_cart),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
