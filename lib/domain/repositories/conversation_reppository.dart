import 'package:kit_chat_app/domain/models/conversations_model.dart';

abstract class ConversationRepository {
  Future<void> createConversation(String userId, String friendId);

  Stream<List<ConversationsModel>> getConversations();
}
