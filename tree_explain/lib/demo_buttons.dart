import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DemoButtons extends StatefulWidget {
  bool _isUnderstood;
  DemoButtons({
    super.key,
    required isUnderstood,
  }) : _isUnderstood = isUnderstood;

  @override
  State<DemoButtons> createState() => _DemoButtonsState();
}

class _DemoButtonsState extends State<DemoButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  widget._isUnderstood = false;
                });
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget._isUnderstood = true;
                });
              },
              child: const Text('Yes'),
            ),
          ],
        ),
        if (widget._isUnderstood) const Text('Awesome!'),
      ],
    );
  }
}
