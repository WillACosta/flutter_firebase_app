import 'package:firebase_auth_app/features/authentication/authentication.dart';

abstract class UserMapper {
  static UserModel toDomain(NetWorkUser data) => UserModel(
        id: data.uid,
        name: data.name,
        email: data.email,
      );

  static List<UserModel> toDomainList(List<NetWorkUser> data) =>
      data.map((e) => UserMapper.toDomain(e)).toList();
}
