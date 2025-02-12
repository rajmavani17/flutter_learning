import 'package:chatgpt_clone/provider/chat_provider.dart';
import 'package:chatgpt_clone/widgets/chat_converstion.dart';
import 'package:chatgpt_clone/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => ChatProvider()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Gemini',
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 49, 54, 56),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Flexible(
                child: ChatConverstion(),
              ),
              CustomInputField(),
            ],
          ),
        ),
      ),
    );
  }
}
