import 'package:dimagi_bot/controller/repository/chat_controller.dart';
import 'package:dimagi_bot/view/widgets/chat_text_field.dart';
import 'package:dimagi_bot/view/widgets/chats_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BotChatScreen extends StatefulWidget {
  const BotChatScreen({super.key});

  @override
  State<BotChatScreen> createState() => _BotChatScreenState();
}

class _BotChatScreenState extends State<BotChatScreen> {
  ChatController _chatController = ChatController();

  @override
  Widget build(BuildContext context) {
    _chatController = Provider.of<ChatController>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple[200],
        title: const Text('Dimagi Chat Bot'),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 11,
              child: ChatsContainer(
                  chatsMessagesList: _chatController.chatMessages)),
          Expanded(
              flex: 2,
              child: ChatTextField(onSendMessage: _chatController.sendMessage))
        ],
      ),
    );
  }
}
