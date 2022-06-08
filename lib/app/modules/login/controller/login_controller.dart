import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blocapp/app/services/auth/auth_service.dart';
import 'package:equatable/equatable.dart';
part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthService _authService;

  LoginController({required AuthService authService})
      : _authService = authService,
        super(const LoginState.initial());

  Future<void> signIn() async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      await _authService.signIn();
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(state.copyWith(
          errorMessage: 'Erro ao realizar o login',
          status: LoginStatus.failure));
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
