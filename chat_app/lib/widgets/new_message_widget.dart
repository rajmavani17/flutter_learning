import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessageWidget extends StatefulWidget {
  const NewMessageWidget({
    super.key,
    this.otherUser,
  });
  final UserModel? otherUser;
  @override
  State<NewMessageWidget> createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _messageEditingController = TextEditingController();

  @override
  void dispose() {
    _messageEditingController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enterMessage = _messageEditingController.text;
    if (enterMessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    _messageEditingController.clear();

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': enterMessage,
      'createdAt': FieldValue.serverTimestamp(),
      'sender': user.uid,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
      'receiver':
          widget.otherUser == null ? 'ALLGROUPCHAT' : widget.otherUser!.uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 14,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageEditingController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                label: Text('Send Message'),
              ),
              maxLines: 5,
              minLines: 1,
            ),
          ),
          IconButton(
            onPressed: _submitMessage,
            icon: Icon(
              Icons.send,
            ),
          ),
        ],
      ),
    );
  }
}
