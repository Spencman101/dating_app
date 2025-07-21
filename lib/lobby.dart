import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_project/Home.dart';
import 'package:flutter/material.dart';

class PlayerLobby extends StatelessWidget {
  const PlayerLobby({super.key});

  Future<List<Map<String, dynamic>>> getSimilarUsers() async {
    final currentUser = 'WxTzBvWCQlMMVYmGpVwY';
    final currentUserDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser)
        .get();

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
      title: 'Waiting Room',
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE6C0AA), Color(0xFFDDA288)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: FutureBuilder<List<Map<String, dynamic>>>(
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
              return Column(
                children: [
                  AppBar(
                    title: const Text('Waiting Room'),
                    backgroundColor: const Color(0xFFB2675E),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        // LEFT SIDE: User List
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: matches.isEmpty
                                  ? const Center(child: Text('No similar users found.'))
                                  : ListView.builder(
                                      padding: const EdgeInsets.all(16),
                                      itemCount: matches.length,
                                      itemBuilder: (context, index) {
                                        final user = matches[index];
                                        return Card(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          margin: const EdgeInsets.symmetric(vertical: 8),
                                          child: ListTile(
                                            leading: const Icon(Icons.person, color: Color(0xFFB2675E)),
                                            title: Text(user['name'] ?? 'No Name'),
                                            subtitle: Text(
                                              'Interests: ${user['interests']?.join(', ') ?? ''}',
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                        // RIGHT SIDE: Chat Box Placeholder
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'Feel free to chat while we set things up for you!',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFB2675E),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Center(
                                      child: Text(
                                        'Chat coming soon...',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                    child: TextField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        hintText: 'Type a message...',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB2675E),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        'Return to Home',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}