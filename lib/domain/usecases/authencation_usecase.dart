import 'package:kit_chat_app/data/repositories/firebase_authencation_repository.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/domain/repositories/authencation_repository.dart';

class AuthencationUseCase {
  final FirebaseAuthencationRepository _authencationRepository;

  AuthencationUseCase(this._authencationRepository);

  Future<UserModel> getUser() async {
    return await _authencationRepository.getUser();
  }

  Future<void> logInWithSocial(AuthencationType type) async {
    return await _authencationRepository.logInWithSocial(type);
  }

  Future<void> logOut() {
    return _authencationRepository.logOut();
  }
}
