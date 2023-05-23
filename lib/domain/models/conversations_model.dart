import 'package:kit_chat_app/domain/models/message_model.dart';
import 'package:kit_chat_app/domain/models/participants_model.dart';

class ConversationsModel {
  final String conversationId;
  final DateTime createdAt;
  final List<Participants> participants;
  final List<Message> messages;

  ConversationsModel({
    required this.conversationId,
    required this.createdAt,
    required this.participants,
    required this.messages,
  });

  factory ConversationsModel.fromJson(Map<String, dynamic> json) {
    return ConversationsModel(
      conversationId: json['conversationId'],
      createdAt: json['createdAt'],
      participants: json['participants'],
      messages: json['messages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'createdAt': createdAt,
      'participants': participants,
      'messages': messages,
    };
  }
}
