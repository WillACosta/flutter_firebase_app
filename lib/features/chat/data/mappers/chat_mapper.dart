import 'package:firebase_auth_app/features/authentication/authentication.dart';

import '../../chat.dart';
import '../models/models.dart';

abstract class ChatDataMapper {
  static MessageModel toMessageDomain(NetworkMessage data) {
    return MessageModel(
      id: data.id,
      messageText: data.messageText,
      sentBy: data.sentBy,
      sentDate: data.sentAt,
    );
  }

  static ChannelModel toChannelDomain(NetworkChannel data) {
    return ChannelModel(
      id: data.id,
      members: UserMapper.toDomainList(data.members),
      createdBy: data.createdBy,
      type: ChannelType.fromString(data.type),
      createdDate: DateTime.parse(data.createdAt!).toString(),
      name: data.name,
      description: data.description,
      image: data.image,
    );
  }

  static List<MessageModel> toMessageDomainList(List<NetworkMessage> data) {
    return data.map((e) => ChatDataMapper.toMessageDomain(e)).toList();
  }

  static List<ChannelModel> toChannelDomainList(List<NetworkChannel> data) {
    return data.map((e) => ChatDataMapper.toChannelDomain(e)).toList();
  }
}
