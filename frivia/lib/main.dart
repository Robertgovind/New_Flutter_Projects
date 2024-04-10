import 'package:flutter/material.dart';
import 'package:frivia/pages/home_page.dart';
import 'package:frivia/pages/start_page.dart';
// https://opentdb.com/api.php?amount=10&difficulty=medium&type=boolean

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "ArchitectsDaughter",
        scaffoldBackgroundColor: const Color.fromRGBO(31, 32, 31, 1.0),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StartPage(),
    );
  }
}
