import 'package:e_commerse/src/screens/home.dart';
import 'package:e_commerse/src/screens/ranking.dart';
import 'package:flutter/material.dart';

class MainTab extends StatefulWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  _MainTabState createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  List? _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': Home(), 'title': 'Home'},
      {'page': Ranking(), 'title': 'Rankings'},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages![_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        // selectedItemColor: Colors.blue[300],
        // unselectedItemColor: const Color(0xFFA5ACD9),
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: 'Rankings',
            icon: Icon(Icons.shopping_cart),
          ),
                  ],
      ),
    );
  }
}
