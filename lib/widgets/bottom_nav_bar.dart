import 'package:flutter/material.dart';
import 'package:movieapps/screens/homescreen.dart';
import 'package:movieapps/screens/more_screen.dart';
import 'package:movieapps/screens/search_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black12,
          height: 70,
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(Icons.photo_library_outlined),
                text: "New & Hot",
              ),
            ],
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xff999999),
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            SearchScreen(),
            MoreScreen(),
          ],
        ),
      ),
    );
  }
}
