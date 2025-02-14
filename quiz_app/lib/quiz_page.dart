import 'package:flutter/material.dart';
import 'package:quiz_app/models/questions.dart';
import 'package:quiz_app/questions_page.dart';
import 'package:quiz_app/result_page.dart';
import 'package:quiz_app/start_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizPageState();
  }
}

class _QuizPageState extends State {
  late Widget activeScreen;
  List<String> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    activeScreen = StartPage(onPressed: switchScreen);
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsPage(
        onSelectAnswer: addAnswers,
      );
    });
  }

  void addAnswers(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == flutterQuestions.length) {
      setState(() {
        activeScreen = ResultPage(
          chosenAnswers: selectedAnswers,
          onPressed: switchScreen,
        );
        selectedAnswers = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple,
              Colors.deepPurple,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: activeScreen,
      ),
    );
  }
}
