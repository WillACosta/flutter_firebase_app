import '../models/models.dart';

abstract class ChatRepository {
  Stream<dynamic> getChannelsByUserId(String uid);
  Stream<List<NetworkMessage>> getMessagesByChatId(String uid);

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
}
