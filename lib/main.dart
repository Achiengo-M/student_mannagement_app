import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_student_screen.dart';
import 'screens/view_student_screen.dart';
import 'screens/search_student_screen.dart';
import 'screens/api_users_screen.dart';

// (ADD THESE LATER WHEN YOU CREATE THEM)
import 'screens/attendance_screen.dart';
import 'screens/attendance_report_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Student Management App",

      // FIRST SCREEN
      home: const SplashScreen(),

      // ROUTES
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),

        '/add': (context) => const AddStudentScreen(),
        '/view': (context) => const ViewStudentScreen(),
        '/search': (context) => const SearchStudentScreen(),

        // API USERS SCREEN
        '/api': (context) => const ApiUsersScreen(),

        // ATTENDANCE (you will build next)
        '/attendance': (context) => const AttendanceScreen(),
        '/report': (context) => const AttendanceReportScreen(),
      },
    );
  }
}