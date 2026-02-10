import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_recoginition/core/storge/token_storage.dart';
import 'package:flutter_food_recoginition/features/auth/presention/cubit/authcubit_state.dart';
import '../../data/repositories/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;
  final TokenStorage storage;

  AuthCubit({required this.repo, required this.storage})
      : super(const AuthState());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final user = await repo.login(email: email, password: password);
      await storage.saveAuth(token: user.token, email: user.email, userName: user.userName);
      emit(state.copyWith(loading: false, user: user, error: null));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString().replaceFirst("ApiException: ", "")));
    }
  }

  Future<void> register({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final user = await repo.register(
        userName: userName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      await storage.saveAuth(token: user.token, email: user.email, userName: user.userName);
      emit(state.copyWith(loading: false, user: user, error: null));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString().replaceFirst("ApiException: ", "")));
    }
  }
}
