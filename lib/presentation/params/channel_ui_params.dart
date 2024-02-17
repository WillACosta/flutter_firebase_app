import 'package:flutter/foundation.dart';

import '../../features/authentication/authentication.dart';
import '../../features/chat/chat.dart';

class ChannelUiParams {
  final ChannelType type;
  final List<UserModel> members;
  final String? name;
  final String? description;
  final String? image;

  ChannelUiParams({
    this.type = ChannelType.private,
    required this.members,
    this.name,
    this.description,
    this.image,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChannelUiParams &&
        other.type == type &&
        listEquals(other.members, members) &&
        other.description == description &&
        other.image == image;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        members.hashCode ^
        description.hashCode ^
        image.hashCode;
  }
}
