import 'package:kit_chat_app/data/repositories/remote/user_repository.dart';

class UserModelUsecase {
  final UserModelRepository _repository;

  UserModelUsecase(this._repository);

  Future<void> updateStatus(String userId, bool isOnline) async {
    return await _repository.updateStatus(userId, isOnline);
  }
}
