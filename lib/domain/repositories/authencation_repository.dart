import 'package:kit_chat_app/domain/models/user_model.dart';

enum AuthencationType { facebook, google }

abstract class AuthencationRepository {
  Future<void> logInWithSocial(AuthencationType type);

  Future<void> logOut();

  Future<UserModel> getUser();
}
