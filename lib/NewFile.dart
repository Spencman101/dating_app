import 'package:flutter/material.dart';
import 'package:dating_app_project/Home.dart';

class NewFile extends StatelessWidget {
  const NewFile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFB2675E),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Georgia',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFD8A48F),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color.fromARGB(255, 252, 244, 244),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB2675E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const ProfileFormPage(),
    );
  }
}

class ProfileFormPage extends StatelessWidget {
  const ProfileFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
        backgroundColor: const Color(0xFFB2675E),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFB6B9), Color(0xFFFFDDE1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: UserForm(),
        ),
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
  final _ageController = TextEditingController();
  final _aboutMeController = TextEditingController();
  final _locationController = TextEditingController();
  String? _selectedGender;
  final List<String> _interests = ["Arts", "Sports", "Technology", "Travel", "Food"];
  final List<String> _selectedInterests = [];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final user = {
        'name': _nameController.text,
        'age': _ageController.text,
        'aboutMe': _aboutMeController.text,
        'gender': _selectedGender ?? '',
        'location': _locationController.text,
        'interests': _selectedInterests,
      };

      showDialog(
        context: context,
        builder: (BuildContext dialog) => AlertDialog(
          title: const Text('Profile Created'),
          content: Text(
            'Welcome, ${user['name']}!\n'
            'Age: ${user['age']}\n'
            'Gender: ${user['gender']}\n'
            'Location: ${user['location']}\n'
            'About: ${user['aboutMe']}\n'
            'Interests: ${(user['interests'] as List?)?.join(', ') ?? 'None'}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialog);
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
              ),
              child: const Text('Go to Homepage'),
            )
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _aboutMeController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.only(top: 16, bottom: 32),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('lib/images/default-profile.png'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (value) => setState(() => _selectedGender = value),
                      activeColor: Theme.of(context).primaryColor,
                    ),
                    const Text('Male'),
                    const SizedBox(width: 24),
                    Radio<String>(
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (value) => setState(() => _selectedGender = value),
                      activeColor: Theme.of(context).primaryColor,
                    ),
                    const Text('Female'),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Age'),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter an age' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _aboutMeController,
                  decoration: const InputDecoration(labelText: 'About Me'),
                  maxLines: 3,
                  validator: (value) => value == null || value.isEmpty ? 'Tell us about yourself' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your location' : null,
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Interests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: _interests.map((interest) {
                    final isSelected = _selectedInterests.contains(interest);
                    return FilterChip(
                      label: Text(interest),
                      labelStyle: const TextStyle(fontSize: 14),
                      selected: isSelected,
                      selectedColor: const Color(0xFFB2675E),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedInterests.add(interest);
                          } else {
                            _selectedInterests.remove(interest);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Create Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
