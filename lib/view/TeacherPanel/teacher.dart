import 'package:app_genesis/view/TeacherPanel/leaderboard_teacher.dart';
import 'package:app_genesis/view/TeacherPanel/profile_teacher.dart';
import 'package:app_genesis/view/TeacherPanel/search_teacher.dart';
import 'package:app_genesis/view/TeacherPanel/teacher_view.dart';
import 'package:flutter/material.dart';

class Teacher extends StatefulWidget {
  const Teacher({super.key});

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> with TickerProviderStateMixin {
  // Current page index
  int _selectedIndex = 0;

  // List of screens to display
  final List<Widget> _screens = [
    const TeacherView(), // Placeholder for the first tab
    const SearchTeacher(),
    const LeaderboardTeacher(),
    const ProfileTeacher(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Teacher Panel"),
        centerTitle: true,
      ),
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
        },
      ),
    );
  }
}
