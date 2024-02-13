import 'package:firebase_auth_app/features/authentication/authentication.dart';

enum ChannelType {
  private,
  group;

  static ChannelType fromString(String value) => switch (value) {
        'private' => ChannelType.private,
        'group' => ChannelType.group,
        _ => throw Exception("Invalid chat type for: $value")
      };
}

class ChannelModel {
  final String id;
  final ChannelType type;
  final List<UserModel> members;
  final String? name;
  final String? description;
  final String? image;
  final String? createdDate;
  final String? createdBy;

  ChannelModel({
    required this.id,
    required this.type,
    required this.members,
    this.name,
    this.description,
    this.image,
    this.createdDate,
    this.createdBy,
  });
}
