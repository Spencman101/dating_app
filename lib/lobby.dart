
import 'package:flutter/material.dart';

class PlayerLobby extends StatelessWidget {
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
              child: const Text('Go Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}