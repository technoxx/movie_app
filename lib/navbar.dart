import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/favourites.dart';
import 'package:movie_app/home_page.dart';
import 'package:movie_app/explore.dart';
import 'package:movie_app/utils/colors.dart';

class NavBar extends StatefulWidget {
  NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int myIndex = 0;
  late final List screenList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screenList = [
      HomePage(),
      Explore(),
      FavouritesTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[myIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: myIndex,
          onTap: (index) {
            setState(() {});
            myIndex = index;
          },
          unselectedItemColor: Colors.white,
          selectedItemColor: maincolor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                size: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.compass,
                size: 30,
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.heart,
                size: 30,
              ),
              label: 'Favourites',
            ),
          ]),
    );
  }
}
