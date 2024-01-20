import 'package:firebase_auth_app/features/authentication/authentication.dart';

abstract class UserMapper {
  static User toDomain(NetWorkUser data) => User(
        id: data.uid,
        name: data.name,
        email: data.email,
      );

  static List<User> toDomainList(List<NetWorkUser> data) =>
      data.map((e) => UserMapper.toDomain(e)).toList();
}
