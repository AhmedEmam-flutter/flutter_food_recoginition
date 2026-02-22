import 'package:flutter_food_recoginition/core/storge/token_storage.dart' show TokenStorage;
import 'package:flutter_food_recoginition/features/auth/presention/cubit/authcubit_cubit.dart';
import 'package:get_it/get_it.dart';
import '../network/api_client.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage());
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<TokenStorage>()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl<ApiClient>()));
  sl.registerFactory<AuthCubit>(() => AuthCubit(repo: sl<AuthRepository>(), storage: sl<TokenStorage>()));
}
