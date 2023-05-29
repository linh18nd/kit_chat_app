import 'package:kit_chat_app/domain/models/conversations_model.dart';
import 'package:kit_chat_app/domain/repositories/conversation_reppository.dart';

class ConversationModelRepository implements ConversationRepository {
  @override
  Future<void> createConversation(String userId, String friendId) {
    // TODO: implement createConversation
    throw UnimplementedError();
  }

  @override
  Stream<List<ConversationsModel>> getConversations() {
    // TODO: implement getConversations
    throw UnimplementedError();
  }
}
