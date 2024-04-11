import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double? _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _registerFromKey = GlobalKey<FormState>();
  String? _name, _email, _password;
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
                _imagePicker(),
                _registerForm(),
                _registerButton(),
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

  Widget _registerButton() {
    return MaterialButton(
      onPressed: () {},
      minWidth: _deviceWidth! * 0.70,
      height: _deviceHeight! * 0.06,
      color: Colors.red,
      child: const Text(
        "Register",
        style: TextStyle(
            fontSize: 23, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _registerForm() {
    return Container(
      height: _deviceHeight! * 0.30,
      child: Form(
        key: _registerFromKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _nameText(),
            _emailTextField(),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _nameText() {
    return TextFormField(
      decoration: InputDecoration(hintText: "Name"),
      validator: (value) =>
          value!.length > 0 ? null : "Please enter correct name",
      onSaved: (newValue) {
        setState(() {
          _name = newValue;
        });
      },
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

  Widget _imagePicker() {
    return Container(
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.15,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://i.pravatar.cc/350"),
        ),
      ),
    );
  }
}
