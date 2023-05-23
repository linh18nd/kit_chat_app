import 'package:kit_chat_app/data/repositories/firebase_authencation_repository.dart';
import 'package:kit_chat_app/domain/repositories/authencation_repository.dart';

class AuthencationUseCase implements AuthencationRepository {
  final FirebaseAuthencationRepository _authencationRepository;

  AuthencationUseCase(this._authencationRepository);

  @override
  Future<String> getUser() {
    throw UnimplementedError();
  }

  @override
  Future<void> logInWithSocial(AuthencationType type) async {
    return await _authencationRepository.logInWithSocial(type);
  }

  @override
  Future<void> logOut() {
    return _authencationRepository.logOut();
  }
}
