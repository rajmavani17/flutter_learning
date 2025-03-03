import 'package:flutter/material.dart';

class LoadingColumn extends StatelessWidget {
  const LoadingColumn({super.key, required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text('$message....'),
        ],
      ),
    );
  }
}
