import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc_test/started/started_screen.dart';
import 'package:flutter_application_1/music/music_screen.dart';
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
  bool isPlayerVisible = false;

  final myScreens = [
    const HomeScreen(),
    const BlocPatternScreen(),
    const AccountScreen(),
    const GetStartedScreen(),
    MusicScreen()
  ];

  void onChangeIndex(int index) {
    setState(() {
      _currentIndex = index;
      // Hiển thị music player overlay chỉ khi tab "Music" được chọn
      isPlayerVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: myScreens,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.hail,
                  color: _currentIndex == 0 ? Colors.red : Colors.blue),
              onPressed: () => onChangeIndex(0),
            ),
            IconButton(
              icon: Icon(Icons.settings,
                  color: _currentIndex == 1 ? Colors.red : Colors.blue),
              onPressed: () => onChangeIndex(1),
            ),
            IconButton(
              icon: Icon(Icons.person,
                  color: _currentIndex == 2 ? Colors.red : Colors.blue),
              onPressed: () => onChangeIndex(2),
            ),
            IconButton(
              icon: Icon(Icons.start,
                  color: _currentIndex == 3 ? Colors.red : Colors.blue),
              onPressed: () => onChangeIndex(3),
            ),
            IconButton(
              icon: Icon(Icons.music_note,
                  color: _currentIndex == 4 ? Colors.red : Colors.blue),
              onPressed: () => onChangeIndex(4),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: isPlayerVisible, // Hiển thị khi isPlayerVisible = true
        child: Container(
          margin: const EdgeInsets.only(
              bottom: 60), // Để căn ngay trên BottomAppBar
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.music_note, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Now Playing',
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  setState(() {
                    isPlayerVisible = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MusicPlayerOverlay extends StatelessWidget {
  const MusicPlayerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.music_note, size: 40, color: Colors.white),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Now Playing',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                'Song Title',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
