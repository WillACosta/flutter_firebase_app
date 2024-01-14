import 'package:firebase_auth_app/core/errors/failure.dart';
import 'package:flutter/services.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

import '../../data/data.dart';

class SignInUseCase {
  SignInUseCase(this._authRepository);
  final AuthenticationRepository _authRepository;

  Future<Result<Unit, AppFailure>> call(SignInParams params) async {
    try {
      await _authRepository.signInWithEmailAndPassword(
        emailAddress: params.email,
        password: params.password,
      );

      return successOf(unit);
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_WRONG_PASSWORD' ||
          e.code == 'ERROR_USER_NOT_FOUND') {
        return failureOf(WrongPasswordOrEmail());
      }

      return failureOf(GenericFailure());
    } catch (e) {
      return failureOf(GenericFailure());
    }
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}
