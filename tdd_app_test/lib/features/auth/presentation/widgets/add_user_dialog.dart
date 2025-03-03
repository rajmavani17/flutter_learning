import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tdd_app_test/features/auth/presentation/bloc/auth_bloc.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(255, 149, 118, 154),
        ),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                label: Text('Username'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(CreateUserEvent(
                    createdAt: DateTime.now().toString(),
                    name: controller.text.trim(),
                    avatar:
                        'https://unsplash.com/photos/a-mountain-covered-in-clouds-and-trees-under-a-yellow-sky-teiYbQVsr-w'));
                Navigator.of(context).pop();
              },
              child: Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }
}
