import 'package:flutter/material.dart';
import 'package:frivia/provider/game_page_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.diff});
  double? _deviceHeight, _deviceWidth;

  final String diff;

  HomePageProvider? pageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
        create: (_context) =>
            HomePageProvider(context: _context, difficultyLevel: diff),
        child: _buildUI());
  }

  Widget _buildUI() {
    return Builder(builder: (_context) {
      pageProvider = _context.watch<HomePageProvider>();
      if (pageProvider!.questions != null) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.05),
              child: _gameUI(),
            ),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    });
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questions(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: _deviceHeight! * 0.02,
            ),
            _falseButton(),
          ],
        )
      ],
    );
  }

  Widget _questions() {
    return Text(
      pageProvider!.getCurrentQuestion(),
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w400, fontSize: 25),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider!.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
        "True",
        style: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider!.answerQuestion("False");
      },
      color: Colors.red,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: Text(
        "True",
        style: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.w400),
      ),
    );
  }
}
