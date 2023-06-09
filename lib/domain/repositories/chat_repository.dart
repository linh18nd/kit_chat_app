import 'package:kit_chat_app/domain/models/message_model.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';

abstract class ChatRepository {
  Future<void> sendMessage(Message message, String conversationId,
      UserModel friend, UserModel userModel);

  Stream<List<Message>> getMessages(String conversationId);

  Future<void> sendNotification(String conversationsId, UserModel friend,
      UserModel userModel, String type);
}
