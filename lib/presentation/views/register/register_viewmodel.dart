import 'package:firebase_auth_app/features/authentication/authentication.dart';

import '../../../core/core.dart';

class RegisterViewModel extends ViewModel {
  RegisterViewModel(this._useCase);
  final RegisterUserUseCase _useCase;

  String? name;
  String? email;
  String? password;

  void setName(String? value) => name = value;
  void setEmail(String? value) => email = value;
  void setPassword(String? value) => password = value;

  submitForm() {
    _registerUser();
  }

  Future<void> _registerUser() async {
    setState(UiState.loading);

    final result = await _useCase(
      RegisterUserParams(
        name: name ?? 'INVALID DATA',
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
