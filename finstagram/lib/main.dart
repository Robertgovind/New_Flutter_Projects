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
      debugShowCheckedModeBanner: false,
      title: 'Finstagram',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/register": (context) => const RegisterPage(),
        "/login": (context) => const LoginPage(),
      },
    );
  }
}
