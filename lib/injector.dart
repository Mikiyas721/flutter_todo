import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo/util/apiQuery.dart';

void inject() {
  GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton(() => BehaviorSubject<String>(),instanceName:'FullName');
  getIt.registerLazySingleton(() => BehaviorSubject<String>(),instanceName:'Email');
  getIt.registerLazySingleton(() => BehaviorSubject<String>(),instanceName:'UserName');
  getIt.registerLazySingleton(() => BehaviorSubject<String>(),instanceName:'Password');
  getIt.registerLazySingleton(() => BehaviorSubject<String>(),instanceName:'PasswordRepeat');
  getIt.registerLazySingleton(() => ApiQuery());
}
