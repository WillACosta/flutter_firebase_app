import 'package:firebase_auth_app/features/authentication/authentication.dart';
import 'package:firebase_auth_app/features/authentication/data/models/network_user.dart';

abstract class UserMapper {
  static User toDomain(NetWorkUser data) => User(
        id: data.uid,
        name: data.name,
        email: data.email,
      );

  static toDomainList(List<NetWorkUser> data) => data.map(
        (e) => UserMapper.toDomain(e),
      );
}
