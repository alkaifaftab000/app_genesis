import 'package:app_genesis/app_functions/routes/routes_names.dart';
import 'package:app_genesis/view/app_info_view.dart';
import 'package:app_genesis/view/TeacherPanel/home_view.dart';
import 'package:app_genesis/view/TeacherPanel/leaderboard_teacher.dart';
import 'package:app_genesis/view/TeacherPanel/profile_teacher.dart';
import 'package:app_genesis/view/TeacherPanel/search_teacher.dart';
import 'package:app_genesis/view/splash_view.dart';
import 'package:app_genesis/view/TeacherPanel/teacher.dart';
import 'package:app_genesis/view/TeacherPanel/teacher_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case RoutesNames.appInfoScreen:
        return MaterialPageRoute(builder: (context) => const AppInfoView());
      case RoutesNames.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeView());
      case RoutesNames.teacherScreen:
        return MaterialPageRoute(builder: (context) => const Teacher());
      case RoutesNames.teacherScreenHome:
        return MaterialPageRoute(builder: (context) => const TeacherView());
      case RoutesNames.searchTeacherScreen:
        return MaterialPageRoute(builder: (context) => const SearchTeacher());
      case RoutesNames.leaderboardTeacherScreen:
        return MaterialPageRoute(
            builder: (context) => const LeaderboardTeacher());
      case RoutesNames.profileTeacherScreen:
        return MaterialPageRoute(builder: (context) => const ProfileTeacher());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('No Screen Found'),
              centerTitle: true,
            ),
            body: const Center(child: Text('No Screen Found')),
          );
        });
    }
  }
}
