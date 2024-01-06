import 'package:firebase_auth_app/features/authentication/authentication.dart';
import 'package:flutter/widgets.dart';

import '../../../core/core.dart';

class SigInViewModel {
  final SignInUseCase _signInUseCase;
  SigInViewModel(this._signInUseCase);

  String? email = 'william@gmail.com';
  String? password = '123456';

  void setEmail(String? value) => email = value;
  void setPassword(String? value) => password = value;

  final ValueNotifier uiState = ValueNotifier(UiState.idle);
  void _setState(UiState state) => uiState.value = state;

  submitForm() {
    _loginWithEmailAndPassword();
  }

  Future<void> _loginWithEmailAndPassword() async {
    _setState(UiState.loading);

    final result = await _signInUseCase(
      SignInParams(
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
