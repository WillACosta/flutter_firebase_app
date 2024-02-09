import '../../models/models.dart';

abstract class RegisterRepository {
  Future<NetWorkUser> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<void> saveUserToStorage(NetWorkUser user);
}
