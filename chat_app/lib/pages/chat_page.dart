import 'package:chat_app/pages/side_drawer.dart';
import 'package:chat_app/providers/current_user_provider.dart';
import 'package:chat_app/widgets/chat_message_widget.dart';
import 'package:chat_app/widgets/new_message_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final String collectionName = 'chat';

  @override
  void initState() {
    super.initState();
    setUserDetails();
  }

  void setUserDetails() async {
    await Provider.of<CurrentUserProvider>(context, listen: false)
        .getCurrentUserDetails();
  }

  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    await fcm.getToken();
    fcm.subscribeToTopic(collectionName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Super Chat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Logout Successfully',
                  ),
                ),
              );
            },
            icon: Icon(Icons.exit_to_app),
            color: Theme.of(context).colorScheme.primary,
            tooltip: 'Logout',
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ChatMessageWidget(
              otherUser: null,
            ),
          ),
          NewMessageWidget(
          ),
        ],
      ),
    );
  }
}
