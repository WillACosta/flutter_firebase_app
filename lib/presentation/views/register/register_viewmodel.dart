import 'package:firebase_auth_app/features/authentication/authentication.dart';
import 'package:flutter/widgets.dart';

import '../../../core/core.dart';

class RegisterViewModel {
  RegisterViewModel(this._useCase);
  final RegisterUserUseCase _useCase;

  String? email = 'william.costa@gmail.com';
  String? password = '123456';

  void setEmail(String? value) => email = value;
  void setPassword(String? value) => password = value;

  final ValueNotifier uiState = ValueNotifier(UiState.idle);
  void _setState(UiState state) => uiState.value = state;

  submitForm() {
    _registerUser();
  }

  Future<void> _registerUser() async {
    _setState(UiState.loading);

    final result = await _useCase(
      RegisterUserParams(
        email: email ?? 'INVALID DATA',
        password: password ?? 'INVALID DATA',
      ),
    );

    result.fold(
      (success) => _setState(UiState.success),
      (failure) => _setState(UiState.error),
    );
  }
}
