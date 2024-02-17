import '../../../../core/core.dart';
import '../../chat.dart';
import '../models/models.dart';

abstract class ChatRepository {
  Stream<dynamic> getChannelsByUserId(String uid);
  StreamListOf<NetworkMessage> getMessagesByChatId(String uid);

  Stream<String?> getCurrentChannelOrNull({
    required List<String> members,
    required ChannelType channelType,
  });

  Future<void> sendMessage({
    required String channelId,
    required String sentBy,
    required String messageText,
  });

  Stream<String> createChannel({
    required String createdByUid,
    required List<String> members,
    required String type,
    String? name,
    String? description,
    String? image,
    String? modifiedAt,
  });

  Future<void> deleteChannel(String channelId);
}
