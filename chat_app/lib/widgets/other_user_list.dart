import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/single_chat_page.dart';
import 'package:chat_app/services/get_all_users_service.dart';
import 'package:flutter/material.dart';

class OtherUserList extends StatefulWidget {
  const OtherUserList({super.key});

  @override
  State<OtherUserList> createState() => _OtherUserListState();
}

class _OtherUserListState extends State<OtherUserList> {
  List<UserModel> allUsers = [];

  Future<List<UserModel>>? allUserFuture;

  @override
  void initState() {
    super.initState();
    allUserFuture = GetAllUsersService.getAllUsers();
  }

  void onSelectProfile(UserModel user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SingleChatPage(
          otherUser: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: allUserFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading users'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No users found'));
        }
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];

                return InkWell(
                  onTap: () {
                    onSelectProfile(user);
                  },
                  child: ListTile(
                    title: Text(user.username),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.imageUrl,
                      ),
                    ),
                    subtitle: Text(user.email),
                  ),
                );
              },
            ),
          );
        }
        return Text('No Users Found');
      },
    );
  }
}
