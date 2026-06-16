import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_student_screen.dart';
import 'screens/view_student_screen.dart';
import 'screens/search_student_screen.dart';

void main() {
  runApp(const My_App());
}

class My_App extends StatelessWidget {
  const My_App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ⭐ APP TITLE (this is what the system sees)
      title: "Student Management App",

      // FIRST SCREEN
      home: SplashScreen(),

      // ROUTES
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/add': (context) => const AddStudentScreen(),
        '/view': (context) => const ViewStudentScreen(),
        '/search': (context) => const SearchStudentScreen(),
      },
    );
  }
}