import 'package:flutter/material.dart';
import 'package:sqlflite/Screens/Homepage.dart';
import 'package:sqlflite/Screens/edit.dart';
import 'package:sqlflite/Screens/search_page.dart';
import 'package:sqlflite/model/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentDetails(),
    );
  }
}
