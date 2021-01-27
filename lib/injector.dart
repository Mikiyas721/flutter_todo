import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './util/apiQuery.dart';

Future<void> inject() async{
  GetIt getIt = GetIt.instance;
  final preference = await SharedPreferences.getInstance();
  getIt.registerSingleton(preference);
  getIt.registerLazySingleton(() => ApiQuery());
  getIt.registerLazySingleton(() => BehaviorSubject<String>(),instanceName:'FullName');
  getIt.registerLazySingleton(() => BehaviorSubject<String>(),instanceName:'Email');
  getIt.registerLazySingleton(() => BehaviorSubject<String>(),instanceName:'UserName');
  getIt.registerLazySingleton(() => BehaviorSubject<String>(),instanceName:'Password');
  getIt.registerLazySingleton(() => BehaviorSubject<String>(),instanceName:'PasswordRepeat');

  getIt.registerLazySingleton(() => BehaviorSubject<DateTime>());
  getIt.registerLazySingleton(() => BehaviorSubject<List>());
}
