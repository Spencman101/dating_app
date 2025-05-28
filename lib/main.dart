import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class User {
  String name;
  String gender;
  String age;
  String aboutMe;
  List interests;

  User({required this.name, required this.gender, required this.age, required this.aboutMe, required this.interests});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile Form',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFB2675E), // muted red
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Georgia', // vintage serif
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF503C3C),
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Color(0xFF3C2F2F),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFD8A48F), // soft rose
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFB2675E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color.fromARGB(0, 240, 240, 240),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent, width: 0.5),
          ),
        ),
      ),
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
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  String? _selectedGender;
  final _aboutMeController = TextEditingController();
  final List<String> _interests = ["Arts", "Sports", "Technology", "Travel", "Food"];
  final List<String> _selectedInterests = [];
  final _locationController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final user = User(
        name: _nameController.text,
        gender: _genderController.text,
        age: _ageController.text,
        aboutMe: _aboutMeController.text,
        interests: _selectedInterests, 
        //Create Json file here?
      );

      // Debug print to console
      //print('Name: ${user.name}');
      //print('age: ${user.age}');
      //print('About Me: ${user.aboutMe}');

      // Optional: Show confirmation dialog
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Profile Created'),
              content: Text(
                'Welcome, ${user.name}!\nage: ${user.age}\nAbout: ${user.aboutMe}\nInterests: ${user.interests}',
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
    _genderController.dispose();
    _ageController.dispose();
    _aboutMeController.dispose();  
    _locationController.dispose();
    _interests.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'lib/images/loading.gif', 
            image: 'lib/images/default-profile.png',
            width: 150,
            fit: BoxFit.cover
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please enter your name'
                        : null,
          ),
          const SizedBox(height: 16),
           Row(
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'Male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  Text('Male'),
                ],
              ),
              SizedBox(width: 24),
              Row(
                children: [
                  Radio<String>(
                    value: 'Female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  Text('Female'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _ageController,
            decoration: const InputDecoration(labelText: 'Age'),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please enter an age'
                        : null,
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          TextFormField(
            controller: _locationController,
            decoration: const InputDecoration(labelText: 'Location'),
            validator: (value) =>
                value == null || value.isEmpty ? 'please enter your location' : null,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: _interests.map((interest) {
              final isSelected = _selectedInterests.contains(interest);
              return FilterChip(
                label: Text(interest),
                selectedColor: Color(0xFFB2675E),
                selected: isSelected,
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
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Create Profile'),
          ),
        ],
      ),
    );
  }
}
