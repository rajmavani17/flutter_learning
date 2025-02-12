import 'package:chatgpt_clone/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatConverstion extends StatefulWidget {
  const ChatConverstion({super.key});

  @override
  State<ChatConverstion> createState() => _ChatConverstionState();
}

class _ChatConverstionState extends State<ChatConverstion> {
  @override
  Widget build(BuildContext context) {
    var chatMessages = context.watch<ChatProvider>().chats;
    return SizedBox(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final message = chatMessages[index]['content'];
                final sender = chatMessages[index]['role'];
                if (sender == 'user') {
                  return ConversationMessageUser(message: message);
                }
                return ConversationMessageModel(message: message);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationMessageUser extends StatelessWidget {
  final String message;
  const ConversationMessageUser({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
 return 
 Container(
      decoration: BoxDecoration(
        color: Color(0x00_30_30_30),
        
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(50),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      child: Text(
        message,
        style: TextStyle(fontSize:20,),
        textAlign: TextAlign.right,
        softWrap: true,
      ),
    );
  }
}

class ConversationMessageModel extends StatelessWidget {
  final String message;
  const ConversationMessageModel(
      {super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 105, 104, 104),
      
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      child: Text(
        message,
        style: TextStyle(fontSize:10),
        textAlign: TextAlign.left,
        softWrap: true,
      ),
    );
  }
}
