import 'package:finstagram/pages/home_page.dart';
import 'package:finstagram/pages/login_page.dart';
import 'package:finstagram/pages/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finstagram',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: "/login",
      routes: {
        "/": (context) => const HomePage(),
        "/register": (context) => RegisterPage(),
        "/login": (context) => LoginPage(),
      },
    );
  }
}
