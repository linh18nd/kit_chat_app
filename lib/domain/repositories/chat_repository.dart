import 'package:kit_chat_app/domain/models/message_model.dart';

abstract class ChatRepository {
  Future<void> sendMessage(Message message, String conversationId);

  Stream<List<Message>> getMessages(String conversationId);
}
