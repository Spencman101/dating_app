import 'package:dating_app_project/Home.dart';
import 'package:flutter/material.dart';

class PlayerLobby extends StatelessWidget {
  const PlayerLobby({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Player Lobby',
      home: Scaffold(
        appBar: AppBar(title: const Text('Player Lobby')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: ElevatedButton(
              child: const Text('Return to Home'),
              onPressed: () {
               Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),);
              },
            ),
          ),
        ),
      ),
    );
  }
}