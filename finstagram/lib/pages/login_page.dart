import 'package:finstagram/pages/register_page.dart';
import 'package:finstagram/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double? _deviceHeight, _deviceWidth;

  FirebaseService? firebaseService;

  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  String? _email, _password;

  @override
  void initState() {
    super.initState();
    firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleText(),
                _loginForm(),
                _loginbutton(),
                _registerpageLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleText() {
    return const Text(
      "Finstagram",
      style: TextStyle(
          fontSize: 32, color: Colors.black, fontWeight: FontWeight.w600),
    );
  }

  Widget _loginbutton() {
    return MaterialButton(
      onPressed: _loginUser,
      minWidth: _deviceWidth! * 0.70,
      height: _deviceHeight! * 0.06,
      color: Colors.red,
      child: const Text(
        "Login",
        style: TextStyle(
            fontSize: 23, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: _deviceHeight! * 0.20,
      child: Form(
          key: _loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _emailTextField(),
              _passwordTextField(),
            ],
          )),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Email"),
      onSaved: (value) {
        setState(() {
          _email = value;
        });
      },
      validator: (value) {
        bool result =
            value!.contains(RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$'));
        return (result ? null : "Please enter a valid email");
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Password"),
      obscureText: true,
      onSaved: (value) {
        setState(() {
          _password = value;
        });
      },
      validator: (value) {
        return value!.length > 6
            ? null
            : "password length must be greater than 6";
      },
    );
  }

  void _loginUser() async {
    if (_loginKey.currentState!.validate()) {
      _loginKey.currentState!.save();
      bool result = await firebaseService!
          .loginUser(email: _email!, password: _password!);
      print(result);
      if (result) Navigator.popAndPushNamed(context, '/');
    }
  }

  Widget _registerpageLink() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => RegisterPage(),
        ),
      ),
      child: const Text(
        "Don't have an account?",
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
