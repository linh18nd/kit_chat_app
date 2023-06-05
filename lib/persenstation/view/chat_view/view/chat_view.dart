import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          SizedBox(height: 70.0.h),
        ],
      ),
      floatingActionButton: _buildSendMessage(context),
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
                  onTap: (url) {
                    controller.openImage(url);
                  },
                  message: message,
                  isMe: controller.isMe(message),
                  friendImage: controller.friend?.avatarUrl ?? '',
                );
              },
              shrinkWrap: true,
            ),
    );
  }

  Widget _buildSendMessage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // Xử lý sự kiện khi nhấn menu
            },
            icon: const Icon(Icons.widgets),
          ),
          IconButton(
            onPressed: () {
              controller.openImagePicker(context);
            },
            icon: const Icon(Icons.image),
          ),
          IconButton(
            onPressed: () {
              // Xử lý sự kiện khi nhấn âm thanh
            },
            icon: const Icon(Icons.volume_up),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0.w),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0.r),
              ),
              child: TextField(
                controller: controller.messageController,
                decoration: InputDecoration(
                  hintText: 'Nhập tin nhắn',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20.0.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0.w),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              controller.sendTextMessage();
            },
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
