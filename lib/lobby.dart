import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_project/Home.dart';
import 'package:flutter/material.dart';

class PlayerLobby extends StatelessWidget {
  const PlayerLobby({super.key});

  Future<List<Map<String, dynamic>>> getSimilarUsers() async {
    final currentUser = 'WxTzBvWCQlMMVYmGpVwY';
    final currentUserDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser).get();

    final List<dynamic> interests = currentUserDoc['interests'];

    final similarQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('interests', arrayContainsAny: interests)
        .get();

    final matches = similarQuery.docs
        .where((doc) => doc.id != currentUser)
        .map((doc) => doc.data())
        .toList();

    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Player Lobby',
      home: Scaffold(
        appBar: AppBar(title: const Text('Player Lobby')),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: getSimilarUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No data returned.'));
            }

            final matches = snapshot.data!;
            if (matches.isEmpty) {
              return const Center(child: Text('No similar users found.'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: matches.length,
                    itemBuilder: (context, index) {
                      final user = matches[index];
                      return ListTile(
                        title: Text(user['name'] ?? 'No Name'),
                        subtitle: Text('Interests: ${user['interests']?.join(', ') ?? ''}'),
                      );
                    },
                  ),
                ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                  Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),);
                  },
                  style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFB2675E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          child: const Text('Return to Home')
                ),
              ),
            ],
          );
          },
        ),
      ),
    );
  }
}