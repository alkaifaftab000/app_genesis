import 'package:app_genesis/view/TeacherPanel/leaderboard_teacher.dart';
import 'package:app_genesis/view/TeacherPanel/profile_teacher.dart';
import 'package:app_genesis/view/TeacherPanel/search_teacher.dart';
import 'package:app_genesis/view/TeacherPanel/teacher_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Teacher extends StatefulWidget {
  const Teacher({super.key});
  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const TeacherView(),
    const SearchTeacher(),
    const LeaderboardTeacher(),
    const ProfileTeacher(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
        title: Text("Teacher Panel",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        centerTitle: true,
        // actions: [IconButton(onPressed: onPressed, icon: icon)],
      ),
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline_rounded),
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
