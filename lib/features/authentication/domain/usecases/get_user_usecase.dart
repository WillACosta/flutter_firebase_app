import '../../authentication.dart';

class GetUserUseCase {
  GetUserUseCase(this._registerRepository);
  final RegisterRepository _registerRepository;

  Future<User> call(String id) async {
    return _registerRepository.getUser(id).then((response) {
      return UserMapper.toDomain(response);
    });
  }
}
