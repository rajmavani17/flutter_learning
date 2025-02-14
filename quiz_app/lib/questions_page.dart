import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/models/questions.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({
    super.key,
    required this.onSelectAnswer,
  });

  final void Function(String answer) onSelectAnswer;
  @override
  State<QuestionsPage> createState() => _QuestionPage();
}

class _QuestionPage extends State<QuestionsPage> {
  int currentQuestionIndex = 0;

  void answerQuestion(String answer) {
    widget.onSelectAnswer(answer);
    setState(() {
      if (currentQuestionIndex < flutterQuestions.length - 1) {
        currentQuestionIndex += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = flutterQuestions[currentQuestionIndex];

    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            currentQuestion.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ...currentQuestion.getShuffledAnswers().map((ques) {
            return AnswerButton(label: ques, onPressed: answerQuestion);
          }),
        ],
      ),
    );
  }
}
