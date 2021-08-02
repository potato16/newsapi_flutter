import 'package:flutter/material.dart';

import 'package:newsapi_flutter/src/view/pages/customize_news_page.dart';
import 'package:newsapi_flutter/src/view/pages/headlines_page.dart';
import 'package:newsapi_flutter/src/view/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Headlines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cut_sharp),
            label: 'Customize',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _bodyWidget() {
    switch (_selectedIndex) {
      case 0:
        return TopHeadlinesPage();
      case 1:
        return CustomizeNewsPage();
      case 2:
        return ProfilePage();
      default:
        return TopHeadlinesPage();
    }
  }
}
