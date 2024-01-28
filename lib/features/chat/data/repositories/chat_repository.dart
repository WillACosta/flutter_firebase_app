import '../../../../core/core.dart';
import '../models/models.dart';

abstract class ChatRepository {
  Stream<dynamic> getChannelsByUserId(String uid);
  StreamListOf<NetworkMessage> getMessagesByChatId(String uid);

  Future<void> sendMessage({
    required String channelId,
    required String sentBy,
    required String messageText,
  });

  Future<String> createChannel({
    required String createdByUid,
    required List<String> members,
    required String type,
    String? description,
    String? image,
    String? modifiedAt,
  });

  Future<void> deleteChannel(String channelId);
}
