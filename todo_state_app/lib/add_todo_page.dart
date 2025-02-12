import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_state_app/cubit/todo_cubit.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a New Todo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: 'Todo'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TodoCubit>().addTodo(textEditingController.text.trim());
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
