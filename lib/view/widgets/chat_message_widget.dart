import 'package:dimagi_bot/controller/constants/constants.dart';
import 'package:dimagi_bot/model/chat_message_model.dart';
import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({super.key, required this.chatMessageModel});
  final ChatMessageModel chatMessageModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (chatMessageModel.messageType == Constants.sender
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (chatMessageModel.messageType == Constants.receiver
                ? Colors.grey.shade200
                : Colors.blue[200]),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            chatMessageModel.messageContent,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
