import 'package:flutter/material.dart';
import 'package:quiz_app/models/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultPage extends StatelessWidget {
  final List<String> chosenAnswers;
  final VoidCallback onPressed;
  const ResultPage({
    super.key,
    required this.chosenAnswers,
    required this.onPressed,
  });

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': flutterQuestions[i].text,
        'correct_answer': flutterQuestions[i].answers[0],
        'chosen_answer': chosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final countofQuestions = flutterQuestions.length;
    final countOfCorrectAnswers = summaryData.where((data) {
      if (data['correct_answer'] == data['chosen_answer']) {
        return true;
      }
      return false;
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You Answers $countOfCorrectAnswers out of $countofQuestions questions correctly",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            QuestionsSummary(
              summaryData: summaryData,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: Text('Restart the quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
