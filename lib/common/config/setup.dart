import 'package:get_it/get_it.dart';
import 'package:kit_chat_app/data/repositories/firebase_authencation_repository.dart';
import 'package:kit_chat_app/domain/usecases/authencation_usecase.dart';
import 'package:kit_chat_app/persenstation/view/home/controllers/home_controller.dart';

final getIt = GetIt.instance;
void setup() {
  //Controller
  getIt.registerLazySingleton<HomeController>(() => HomeController());

  //UseCase
  getIt.registerFactory<AuthencationUseCase>(
      () => AuthencationUseCase(getIt<FirebaseAuthencationRepository>()));

  //Repository
  getIt.registerFactory<FirebaseAuthencationRepository>(
      () => FirebaseAuthencationRepository());
}
