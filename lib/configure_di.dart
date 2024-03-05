import 'package:get_it/get_it.dart';
import 'package:productive_families/app_store/app_store.dart';
import 'package:productive_families/core/logic/global_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> configureInjection() async {
  /// data sources
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final AppStore appStore = AppStore();

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<GlobalBloc>(() => GlobalBloc());
  getIt.registerLazySingleton<AppStore>(() => appStore);
}
