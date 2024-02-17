import 'package:firebase_auth_app/features/chat/chat.dart';

import '../../features/authentication/authentication.dart';

String resolveChannelName({
  required ChannelType type,
  required List<UserModel> users,
  required String currentUserId,
  String? groupName,
}) {
  if (type == ChannelType.private) {
    final foundChattingWith = users.where((user) {
      return user.id != currentUserId && type == ChannelType.private;
    }).toList();

    return foundChattingWith.first.name;
  }

  return groupName!;
}
