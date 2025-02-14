class QuizQuestionModel {
  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    List<String> temp = List.of(answers);
    temp.shuffle();
    return temp;
  }

  QuizQuestionModel({required this.text, required this.answers});
}
