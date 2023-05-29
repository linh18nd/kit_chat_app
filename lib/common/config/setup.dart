import 'package:get_it/get_it.dart';
import 'package:kit_chat_app/data/repositories/remote/firebase_authencation_repository.dart';
import 'package:kit_chat_app/data/repositories/remote/chat_repository.dart';
import 'package:kit_chat_app/data/repositories/remote/user_repository.dart';
import 'package:kit_chat_app/domain/usecases/authencation_usecase.dart';
import 'package:kit_chat_app/domain/usecases/chat_model_usecase.dart';
import 'package:kit_chat_app/domain/usecases/user_usecase.dart';
import 'package:kit_chat_app/persenstation/view/home/controllers/home_controller.dart';

final getIt = GetIt.instance;
void setup() {
  //Controller
  getIt.registerLazySingleton<HomeController>(() => HomeController());

  //UseCase
  getIt.registerFactory<AuthencationUseCase>(
      () => AuthencationUseCase(getIt<FirebaseAuthencationRepository>()));
  getIt.registerFactory<ChatModelUsecase>(
      () => ChatModelUsecase(getIt<ChatModelRepository>()));
  getIt.registerFactory<UserModelUsecase>(
      () => UserModelUsecase(getIt<UserModelRepository>()));

  //Repository
  getIt.registerFactory<FirebaseAuthencationRepository>(
      () => FirebaseAuthencationRepository());
  getIt.registerFactory<ChatModelRepository>(() => ChatModelRepository());
  getIt.registerFactory<UserModelRepository>(() => UserModelRepository());
}
