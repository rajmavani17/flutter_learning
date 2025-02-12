import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_state_app/cubit/todo_cubit.dart';
import 'package:todo_state_app/models/todo_model.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        centerTitle: true,
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];
              return ListTile(
                title: Text(
                  todo.name,
                ),
                subtitle: Text(
                  todo.createdAt.toString(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-todo');
        },
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
