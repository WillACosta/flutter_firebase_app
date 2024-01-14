import 'package:firebase_auth_app/core/core.dart';
import 'package:firebase_auth_app/features/authentication/data/mappers/user_mapper.dart';
import 'package:firebase_auth_app/features/contacts/contacts.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

import '../../authentication/authentication.dart';

class GetAllContactsUseCase {
  final ContactsRepository _repository;

  GetAllContactsUseCase(this._repository);

  Future<Result<List<User>, AppFailure>> call() async {
    try {
      final result = await _repository.getUsers();
      return successOf(UserMapper.toDomainList(result));
    } catch (e) {
      return failureOf(GenericFailure());
    }
  }
}
