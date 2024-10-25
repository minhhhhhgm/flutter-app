import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/account/account_screen/account_screen.dart';
import 'package:flutter_application_1/screens/bloc_pattern/bloc_pattern_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final myScreens = [
    const HomeScreen(),
    // const Center(child: Text('Setting Screen')),
    const BlocPatternScreen(),
    const AccountScreen(),
  ];

  void onChangeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('DEMO'),
      // ),
      body: IndexedStack(
        index: _currentIndex,
        children: myScreens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onChangeIndex,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.blue,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 25,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.hail), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Setting'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Account'),
          ]),
    );
  }
}
