import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Dashboard")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add');
              },
              child: const Text("Add Student"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/view');
              },
              child: const Text("View Students"),
            ),
          ],
        ),
      ),
    );
  }
}