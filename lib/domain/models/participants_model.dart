import 'package:kit_chat_app/domain/models/message_model.dart';

class ChatModel {
  List<Message> messages;
  ChatModel({required this.messages});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      messages: List<Message>.from(json['messages']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messages': messages,
    };
  }
}
