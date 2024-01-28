import 'package:firebase_auth_app/features/contacts/contacts.dart';

import '../../authentication.dart';

class GetUserUseCase {
  GetUserUseCase(this._contactsRepository);
  final ContactsRepository _contactsRepository;

  Stream<UserModel> call(String id) {
    return _contactsRepository.getUser(id).map(UserMapper.toDomain);
  }
}
