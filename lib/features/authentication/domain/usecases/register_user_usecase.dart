import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';

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

      await _registerRepository.registerUserToTheStorage(
        uid: user?.uid ?? const Uuid().v4(),
        displayName: user?.displayName ?? 'Unknown',
        email: user?.email ?? 'No email address',
      );

      await _authRepository.signInWithEmailAndPassword(
        emailAddress: params.email,
        password: params.password,
      );

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
