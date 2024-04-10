import 'package:flutter/material.dart';
import 'package:frivia/pages/home_page.dart';

class StartPage extends StatefulWidget {
  StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  double? _deviceWidth, _deviceHeight;

  double currentDifficulty = 0;
  List<String> difficultyText = ["Easy", "Medium", "Hard"];

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                _fistText(),
                _secondText(),
              ],
            ),
            _sliderScale(),
            _startButton(),
          ],
        ),
      ),
    );
  }

  Widget _fistText() {
    return const Text(
      "Frivia",
      style: TextStyle(
          fontSize: 50, fontWeight: FontWeight.w600, color: Colors.white),
    );
  }

  Widget _secondText() {
    return Text(
      difficultyText[currentDifficulty.toInt()],
      style: TextStyle(color: Colors.white, fontSize: 32),
    );
  }

  Widget _sliderScale() {
    return Slider(
      value: currentDifficulty,
      min: 0,
      max: 2,
      divisions: 2,
      label: "Difficulty",
      onChanged: (value) {
        currentDifficulty = value;
        setState(() {});
      },
    );
  }

  Widget _startButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return HomePage(
                diff: difficultyText[currentDifficulty.toInt()].toLowerCase(),
              );
            },
          ),
        );
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.08,
      child: const Text(
        "Start",
        style: TextStyle(fontSize: 28, color: Colors.white),
      ),
    );
  }
}
