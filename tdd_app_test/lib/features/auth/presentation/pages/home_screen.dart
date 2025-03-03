import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tdd_app_test/features/auth/presentation/widgets/add_user_dialog.dart';
import 'package:tdd_app_test/features/auth/presentation/widgets/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() {
    context.read<AuthBloc>().add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
              ),
            ),
          );
        }
        if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUser
              ? LoadingColumn(message: 'Getting Users List')
              : state is CreatingUser
                  ? LoadingColumn(message: 'Creating User')
                  : state is UsersLoaded
                      ? ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return ListTile(
                              title: Text(user.name),
                              leading: Image.network(user.avatar),
                              subtitle: Text(user.createdAt),
                            );
                          },
                        )
                      : SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => AddUserDialog(
                  controller: _nameController,
                ),
              );

              context.read<AuthBloc>().add(
                    CreateUserEvent(
                        createdAt: DateTime.now().toString(),
                        name: 'name',
                        avatar: 'avatar'),
                  );
            },
            icon: Icon(Icons.add),
            label: Text('Add User'),
          ),
        );
      },
    );
  }
}
