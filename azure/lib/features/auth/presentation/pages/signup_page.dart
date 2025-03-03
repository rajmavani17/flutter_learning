import 'package:azure/features/auth/presentation/widgets/image_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    int _currentPosition = 0;
    int _totalDots = 3;

    double _validPosition(double position) {
      if (position >= _totalDots) return 0.0;
      if (position < 0.0) return _totalDots - 1;
      return position;
    }

    void _updatePosition(double position) {
      setState(() => _currentPosition = _validPosition(position));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //main image
            ImageText(index: _currentPosition),
            DotsIndicator(
              dotsCount: 3,
              position: _currentPosition.toDouble(),
              onTap: (position) {
                _updatePosition(position.toDouble());
              },
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Color.fromARGB(255, 127, 61, 255),
                ),
                foregroundColor: WidgetStatePropertyAll(
                  Colors.white,
                ),
              ),
              child: Text(
                'Sign Up',
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Color.fromARGB(255, 255, 229, 255),
                ),
                foregroundColor: WidgetStatePropertyAll(
                  Color.fromARGB(255, 127, 61, 255),
                ),
              ),
              child: Text(
                'Login',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
