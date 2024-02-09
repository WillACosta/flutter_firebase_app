import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';

class RegisterUserUseCase {
  RegisterUserUseCase(this._registerRepository, this._authRepository);

  final RegisterRepository _registerRepository;
  final AuthenticationRepository _authRepository;

  Future<Result<Unit, AppFailure>> call(RegisterUserParams params) async {
    try {
      final user = await _registerRepository.createUserWithEmailAndPassword(
        name: params.name,
        email: params.email,
        password: params.password,
      );

      Future.wait([
        _registerRepository.saveUserToStorage(user),
        _authRepository.signInWithEmailAndPassword(
          emailAddress: params.email,
          password: params.password,
        ),
      ]);

      return successOf(unit);
    } catch (e) {
      return failureOf(GenericFailure());
    }
  }
}

class RegisterUserParams {
  final String name;
  final String email;
  final String password;

  RegisterUserParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
