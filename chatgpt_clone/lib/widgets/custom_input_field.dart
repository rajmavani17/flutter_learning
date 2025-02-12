import 'package:chatgpt_clone/provider/chat_provider.dart';
import 'package:chatgpt_clone/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    super.key,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late TextEditingController textController;

  void handleSubmit(value) async {
    Map<String, String> userInput = {"role": 'user', "content": value};
    Provider.of<ChatProvider>(context, listen: false).addMessage(userInput);

    Map<String, dynamic> response =
        await ApiService().getResponseFromGemini(value);
    String responseMessage =
        response['candidates'][0]['content']['parts'][0]['text'];
    Map<String, String> chat = {"role": "model", "content": responseMessage};
    Provider.of<ChatProvider>(context, listen: false).addMessage(chat);
    textController.text = '';
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  InputDecoration getDecoration() {
    return InputDecoration(
      hintText: 'Enter Your Message',
      suffixIcon: CustomSuffixIconButton(
        handleSubmit: () {
          handleSubmit(textController.value.text);
        },
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 3, color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            width: 3, color: Color.fromARGB(255, 143, 141, 141)),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        handleSubmit(value);
      },
      decoration: getDecoration(),
      controller: textController,
    );
  }
}

class CustomSuffixIconButton extends StatefulWidget {
  final VoidCallback handleSubmit;
  const CustomSuffixIconButton({super.key, required this.handleSubmit});

  @override
  State<CustomSuffixIconButton> createState() => _CustomSuffixIconButtonState();
}

class _CustomSuffixIconButtonState extends State<CustomSuffixIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: widget.handleSubmit,
        icon: Icon(Icons.subdirectory_arrow_right_sharp));
  }
}
