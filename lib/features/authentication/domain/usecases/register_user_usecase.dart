import 'package:firebase_auth_app/features/authentication/data/authentication_repository.dart';
import 'package:firebase_auth_app/features/authentication/data/register_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/core.dart';
import '../models/user_model.dart';

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
      final userModel = UserModel(
        uid: user?.uid ?? const Uuid().v4(),
        name: user?.displayName ?? 'User',
        email: user?.email ?? 'no email address',
      );

      await _registerRepository.saveUserToStorage(
        uid: userModel.uid,
        displayName: userModel.name,
        email: userModel.email,
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
