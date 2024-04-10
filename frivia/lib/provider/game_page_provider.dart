import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:frivia/pages/home_page.dart';

class HomePageProvider extends ChangeNotifier {
  final _dio = Dio();
  final int maxQues = 10;

  List? questions;
  int currentQuesCount = 0;
  int score = 0;

  final String difficultyLevel;

  BuildContext context;
  HomePageProvider({required this.context, required this.difficultyLevel}) {
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestions();
  }

  Future<void> _getQuestions() async {
    var _res = await _dio.get(
      '',
      queryParameters: {
        "amount": maxQues,
        "type": "boolean",
        "difficulty": difficultyLevel,
      },
    );
    print(difficultyLevel);
    var data = jsonDecode(_res.toString());
    questions = data["results"];
    notifyListeners();
  }

  String getCurrentQuestion() {
    return questions![currentQuesCount]["question"];
  }

  void answerQuestion(String ans) async {
    bool isCorrect = questions![currentQuesCount]["correct_answer"] == ans;
    currentQuesCount++;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(isCorrect ? Icons.check_circle : Icons.cancel_sharp),
          iconColor: Colors.white,
        );
      },
    );
    score += isCorrect ? 1 : 0;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    Navigator.pop(context);
    if (currentQuesCount == 10) {
      endState();
    } else {}
    notifyListeners();
  }

  Future<void> endState() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.greenAccent,
            title: const Text(
              "Game Ended!!!",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            content: Text("Score : $score/$maxQues"),
          );
        });

    await Future.delayed(
      const Duration(seconds: 4),
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
