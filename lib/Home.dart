import 'package:dating_app_project/Lobby.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage',
      home: Scaffold(
        appBar: AppBar(title: const Text('Player Lobby')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [ ElevatedButton(
              onPressed:() => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PlayerLoby()),),
              child: const Text('To Lobby'),
              ),
            ElevatedButton(
              child: const Text('Sign Out'),
              onPressed: () => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => main()),),
          ),
            ]
      ),
    ),
    ),
    );
  }
}