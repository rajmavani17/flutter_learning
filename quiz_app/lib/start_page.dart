import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  final VoidCallback onPressed;
  const StartPage({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            color: Color.fromARGB(175, 255, 255, 255),
          ),
          SizedBox(
            height: 50,
          ),
          Text('Learn Flutter the fun way!',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              )),
          SizedBox(
            height: 20,
          ),
          OutlinedButton.icon(
            onPressed: onPressed,
            style: ButtonStyle(),
            label: Text(
              'Start Quiz',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.arrow_right_alt,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
