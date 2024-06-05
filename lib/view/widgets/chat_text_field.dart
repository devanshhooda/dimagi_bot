import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  ChatTextField({super.key, required this.onSendMessage});
  final Function(String message) onSendMessage;
  final TextEditingController textMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: textMessageController,
        style: const TextStyle(fontSize: 17),
        decoration: InputDecoration(
            hintText: "Type here...",
            hintStyle: TextStyle(color: Colors.grey.shade600),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey.shade100)),
            suffixIcon: IconButton(
                onPressed: () {
                  onSendMessage(textMessageController.text);
                },
                icon: const Icon(Icons.send))),
      ),
    );
  }
}
