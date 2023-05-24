import 'package:uuid/uuid.dart';

enum MessageType { text, image, video, audio, file }

class Message {
  final String? messageId;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final MessageType type;

  Message({
    String? messageId,
    required this.senderId,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
  }) : messageId = messageId ?? const Uuid().v4();

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      type: MessageType.values[json['type'] as int],
      messageId: json['messageId'],
      senderId: json['senderId'],
      content: json['content'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'type': type.index,
    };
  }
}
