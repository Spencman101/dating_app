import 'package:dating_app_project/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dating_app_project/NewFile.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
@override
  Widget build(BuildContext context) {
    return MaterialApp( home: const SignIn(),);}}

class SignIn extends StatelessWidget{
  const SignIn({super.key});
@override
  Widget build(BuildContext context) {
      return( Scaffold(
        appBar: AppBar(title: const Text('Sign In')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [ ElevatedButton(
              onPressed:() => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),),
      style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFB2675E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          child: const Text('Sign in'),
              ),
            ElevatedButton(
              onPressed: () => 
               Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NewFile()),),
      style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFB2675E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          child: const Text('New File'),
          ),
            ]
      ),
    ),
    )
    );
  }
}

