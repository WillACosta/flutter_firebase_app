import 'package:firebase_auth_app/features/contacts/contacts.dart';

import '../../authentication.dart';

class GetUserUseCase {
  GetUserUseCase(this._contactsRepository);
  final ContactsRepository _contactsRepository;

  Future<UserModel> call(String id) async {
    final data = await _contactsRepository.getUser(id);
    return UserMapper.toDomain(data);
  }
}
