import 'package:dimagi_bot/model/chat_message_model.dart';
import 'package:dimagi_bot/view/widgets/chat_message_widget.dart';
import 'package:flutter/material.dart';

class ChatsContainer extends StatelessWidget {
  const ChatsContainer({super.key, required this.chatsMessagesList});
  final List? chatsMessagesList;
  @override
  Widget build(BuildContext context) {
    if (chatsMessagesList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (chatsMessagesList!.isEmpty) {
      return const Center(
        child: Text("You chat with us starts here ;)", 
        style: TextStyle(fontSize: 20, color: Colors.purple, 
          fontWeight: FontWeight.bold)),
      );
    }

    return ListView.builder(
        itemCount: chatsMessagesList?.length,
        itemBuilder: (context, index) => ChatMessageWidget(
            chatMessageModel:
                ChatMessageModel.fromJSON(chatsMessagesList![index])));
  }
}
