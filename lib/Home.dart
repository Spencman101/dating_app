import 'package:flutter/material.dart';
import 'package:dating_app_project/lobby.dart';
import 'package:dating_app_project/main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage',
      home: Scaffold(
        appBar: AppBar(title: const Text('Home Page')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [ ElevatedButton(
              onPressed:() => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PlayerLobby()),),
              child: const Text('To Lobby'),
              style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFB2675E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
              ),
            ElevatedButton(
              child: const Text('Sign Out'),
              onPressed: () => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),),
      style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFB2675E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          ),
            ]
      ),
    ),
    ),
    );
  }
}