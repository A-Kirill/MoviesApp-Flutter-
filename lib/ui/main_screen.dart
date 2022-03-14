import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'favorite_list.dart';
import 'movie_list.dart';
import 'settings_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const selectedColor = Color(0xff6DA3D1);
  List<Widget> pageList = <Widget>[];

  @override
  void initState() {
    super.initState();
    pageList.add(const MoviesList());
    pageList.add(const FavoriteList());
    pageList.add(const SettingsScreen());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.movie,
                  color: _selectedIndex == 0 ? selectedColor : Colors.grey),
              label: translate('bottom_bar.list')),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark,
                  color: _selectedIndex == 1 ? selectedColor : Colors.grey),
              label: translate('bottom_bar.bookmarks')),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings,
                  color: _selectedIndex == 2 ? selectedColor : Colors.grey),
              label: translate('bottom_bar.settings')),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: selectedColor,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pageList,
      ),
    );
  }
}
