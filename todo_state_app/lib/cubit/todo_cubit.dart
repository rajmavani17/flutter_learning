import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_state_app/models/todo_model.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  void addTodo(String title) {
    Todo newTodo = Todo(name: title, createdAt: DateTime.now());

    emit([...state, newTodo]);
  }
  @override
  void onChange(Change<List<Todo>> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change.nextState[change.nextState.length - 1].name);
  }
}
