import 'package:kit_chat_app/domain/models/message_model.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';

abstract class ChatRepository {
  Future<void> sendMessage(Message message, String conversationId,
      String recipientToken, UserModel userModel);

  Stream<List<Message>> getMessages(String conversationId);
}
