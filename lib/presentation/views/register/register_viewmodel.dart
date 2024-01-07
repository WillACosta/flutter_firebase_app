import 'package:firebase_auth_app/features/authentication/authentication.dart';

import '../../../core/core.dart';

class RegisterViewModel extends ViewModel {
  RegisterViewModel(this._useCase);
  final RegisterUserUseCase _useCase;

  String? email = 'william.costa@gmail.com';
  String? password = '123456';

  void setEmail(String? value) => email = value;
  void setPassword(String? value) => password = value;

  submitForm() {
    _registerUser();
  }

  Future<void> _registerUser() async {
    setState(UiState.loading);

    final result = await _useCase(
      RegisterUserParams(
        email: email ?? 'INVALID DATA',
        password: password ?? 'INVALID DATA',
      ),
    );

    result.fold(
      (success) => setState(UiState.success),
      (failure) => setState(UiState.error),
    );
  }
}
