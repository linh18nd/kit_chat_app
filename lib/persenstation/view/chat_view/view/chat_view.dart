import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/chat_view/controllers/chat_view_controller.dart';
import 'package:kit_chat_app/persenstation/view/chat_view/view/widgets/conversations_title.dart.dart';
import 'package:kit_chat_app/persenstation/view/chat_view/view/widgets/message_view.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ConversationTitle(friend: controller.friend),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageView(),
          ),
          _buildSendMessage(),
        ],
      ),
    );
  }

  Widget _buildMessageView() {
    return Obx(
      () => controller.messages.isEmpty
          ? const Center(
              child: Text("Không có tin nhắn"),
            )
          : ListView.builder(
              reverse: true,
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final message = controller.messages[index];
                return MessageView(
                  message: message,
                  isMe: controller.isMe(message),
                  friendImage: controller.friend?.avatarUrl ?? '',
                );
              },
              shrinkWrap: true,
            ),
    );
  }

  Widget _buildSendMessage() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              decoration: const InputDecoration(
                hintText: 'Nhập tin nhắn',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.image),
          ),
          IconButton(
            onPressed: () {
              controller.sendMessage();
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
