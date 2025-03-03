import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/current_user_provider.dart';
import 'package:chat_app/widgets/chat_message_widget.dart';
import 'package:chat_app/widgets/new_message_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleChatPage extends StatefulWidget {
  const SingleChatPage({
    super.key,
    required this.otherUser,
  });

  final UserModel otherUser;
  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  String collectionName = 'chat';
  late final UserModel currentUser;
  @override
  void initState() {
    super.initState();

    currentUser =
        Provider.of<CurrentUserProvider>(context, listen: false).currentUser!;

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
        title: Row(
          children: [
            CircleAvatar(
              child: Image.network(widget.otherUser.imageUrl),
            ),
            Text(widget.otherUser.username),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessageWidget(
              otherUser: widget.otherUser,
            ),
          ),
          NewMessageWidget(
            otherUser: widget.otherUser,
          ),
        ],
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     final currentUser = Provider.of<CurrentUserProvider>(context).currentUser;
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             CircleAvatar(
//               child: Image.network(widget.otherUser.imageUrl),
//             ),
//             Text(widget.otherUser.username),
//           ],
//         ),
//       ),
//     );
//   }
// }
