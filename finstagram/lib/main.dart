import 'package:finstagram/pages/home_page.dart';
import 'package:finstagram/pages/login_page.dart';
import 'package:finstagram/pages/register_page.dart';
import 'package:finstagram/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBg-rjiErwvXWT82uhJR3pP4EnU5cZC2bs',
      appId: '1:781776996384:android:8ad25dc67660574b45d445',
      messagingSenderId: '781776996384',
      projectId: 'finstagram-52145',
      storageBucket: 'finstagram-52145.appspot.com',
    ),
  );

  GetIt.instance.registerSingleton<FirebaseService>(
    FirebaseService(),
  );
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
      initialRoute: "/login",
      routes: {
        "/": (context) => const HomePage(),
        "/register": (context) => const RegisterPage(),
        "/login": (context) => const LoginPage(),
      },
    );
  }
}
