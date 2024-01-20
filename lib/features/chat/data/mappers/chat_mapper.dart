import '../../chat.dart';
import '../models/network_channel.dart';
import '../models/network_message.dart';

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
      members: data.members,
      createdBy: data.createdBy,
      type: ChannelType.fromString(data.type),
      createdDate: data.createdAt,
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
