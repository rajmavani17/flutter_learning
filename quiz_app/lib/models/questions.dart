
import 'package:quiz_app/models/quiz_question_model.dart';

List<QuizQuestionModel> flutterQuestions = [
  QuizQuestionModel(
    text: "What is Flutter?",
    answers: [
      "A framework for mobile, web, and desktop",
      "A programming language",
      "A database system",
      "An operating system"
    ],
  ),
  QuizQuestionModel(
    text: "Which language is used to develop Flutter apps?",
    answers: ["Dart", "Java", "Swift", "Kotlin"],
  ),
  QuizQuestionModel(
    text: "What is a Widget in Flutter?",
    answers: [
      "A UI component",
      "A database table",
      "A package manager",
      "A command-line tool"
    ],
  ),
  QuizQuestionModel(
    text: "Which widget is used to create a scrollable list?",
    answers: ["ListView", "Column", "Row", "Container"],
  ),
  QuizQuestionModel(
    text: "How do you navigate between screens in Flutter?",
    answers: ["Navigator", "Router", "Scaffold", "AppBar"],
  ),
  QuizQuestionModel(
    text: "Which widget is used to create a button in Flutter?",
    answers: ["ElevatedButton", "Text", "Image", "Column"],
  ),
  QuizQuestionModel(
    text: "What is the function of 'setState()' in StatefulWidget?",
    answers: [
      "To update the UI",
      "To destroy the widget",
      "To fetch API data",
      "To create a new instance"
    ],
  ),
  QuizQuestionModel(
    text: "Which file contains the entry point for a Flutter app?",
    answers: ["main.dart", "index.html", "app.js", "config.yaml"],
  ),
  QuizQuestionModel(
    text: "What is used to manage dependencies in a Flutter project?",
    answers: ["pubspec.yaml", "package.json", "gradle.build", "config.xml"],
  ),
  QuizQuestionModel(
    text: "Which command is used to run a Flutter app?",
    answers: ["flutter run", "flutter build", "flutter serve", "flutter start"],
  ),
];

List<QuizQuestionModel> flutterIntermediateQuestions = [
  QuizQuestionModel(
    text: "What is the difference between a StatefulWidget and a StatelessWidget?",
    answers: [
      "StatefulWidget can update its state, StatelessWidget cannot",
      "StatelessWidget can update its state, StatefulWidget cannot",
      "Both can update their state",
      "Neither can update their state"
    ],
  ),
  QuizQuestionModel(
    text: "What is the purpose of the 'BuildContext' in Flutter?",
    answers: [
      "It represents a handle to the UI framework",
      "It is used to access the database",
      "It is a debugging tool",
      "It defines the main.dart entry point"
    ],
  ),
  QuizQuestionModel(
    text: "Which lifecycle method is called when a StatefulWidget is removed from the widget tree?",
    answers: [
      "dispose()",
      "initState()",
      "setState()",
      "build()"
    ],
  ),
  QuizQuestionModel(
    text: "Which package is commonly used for state management in Flutter?",
    answers: [
      "provider",
      "flutter_http",
      "flutter_localizations",
      "flutter_test"
    ],
  ),
  QuizQuestionModel(
    text: "What does 'hot reload' do in Flutter?",
    answers: [
      "Applies code changes without losing state",
      "Restarts the app completely",
      "Recompiles the app from scratch",
      "Deletes temporary files"
    ],
  ),
  QuizQuestionModel(
    text: "What is the function of the 'async' and 'await' keywords in Flutter?",
    answers: [
      "To handle asynchronous operations",
      "To create a new thread",
      "To improve app performance",
      "To initialize a widget"
    ],
  ),
  QuizQuestionModel(
    text: "How do you handle exceptions in Flutter?",
    answers: [
      "Using try-catch blocks",
      "Using setState()",
      "By restarting the app",
      "By using build()"
    ],
  ),
  QuizQuestionModel(
    text: "Which widget is used to create a flexible UI layout?",
    answers: [
      "Expanded",
      "ListView",
      "Column",
      "Container"
    ],
  ),
  QuizQuestionModel(
    text: "What is the purpose of a FutureBuilder in Flutter?",
    answers: [
      "To manage asynchronous data and UI updates",
      "To handle animation effects",
      "To create widgets dynamically",
      "To build a database query"
    ],
  ),
  QuizQuestionModel(
    text: "How do you pass data between screens in Flutter?",
    answers: [
      "Using Navigator.push with arguments",
      "Using setState()",
      "Using the main.dart file",
      "Using initState()"
    ],
  ),
];
