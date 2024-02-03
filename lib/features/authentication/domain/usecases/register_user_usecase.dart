import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';

class RegisterUserUseCase {
  final AuthenticationRepository _authRepository;
  final RegisterRepository _registerRepository;

  RegisterUserUseCase(
    this._authRepository,
    this._registerRepository,
  );

  Future<Result<Unit, AppFailure>> call(RegisterUserParams params) async {
    try {
      final credentials = await _authRepository.createUserWithEmailAndPassword(
        emailAddress: params.email,
        password: params.password,
      );

      final user = credentials.user;

      Future.wait([
        _registerRepository.registerUserToTheStorage(
          NetWorkUser.fromFirebaseAuth(user),
        ),
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
  final String email;
  final String password;

  RegisterUserParams({
    required this.email,
    required this.password,
  });
}
