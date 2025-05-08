import 'package:flutter/material.dart';
import 'screens/volunteer_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan label DEBUG
      title: 'Volunteer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VolunteerList(),
    );
  }
}