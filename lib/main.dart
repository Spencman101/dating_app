import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class User {
  String name;
  String username;
  String aboutMe;

  User({required this.name, required this.username, required this.aboutMe});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile Form',
      home: Scaffold(
        appBar: AppBar(title: const Text('Create Profile')),
        body: const Padding(padding: EdgeInsets.all(16.0), child: UserForm()),
      ),
    );
  }
}

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _aboutMeController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final user = User(
        name: _nameController.text,
        username: _usernameController.text,
        aboutMe: _aboutMeController.text,
        //Create Json file here?
      );

      // Debug print to console
      print('Name: ${user.name}');
      print('Username: ${user.username}');
      print('About Me: ${user.aboutMe}');

      // Optional: Show confirmation dialog
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Profile Created'),
              content: Text(
                'Welcome, ${user.name}!\nUsername: ${user.username}\nAbout: ${user.aboutMe}',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _aboutMeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please enter your name'
                        : null,
          ),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please enter a username'
                        : null,
          ),
          TextFormField(
            controller: _aboutMeController,
            decoration: const InputDecoration(labelText: 'About Me'),
            maxLines: 3,
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Tell us about yourself'
                        : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Create Profile'),
          ),
        ],
      ),
    );
  }
}
