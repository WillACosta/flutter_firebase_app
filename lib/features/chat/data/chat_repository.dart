import '../domain/domain.dart';

abstract class ChatRepository {
  Future<List<ChatModel>> getChatsByUser(String uid);
  Future<List<MessageModel>> getMessagesByChatId(String uid);

  Future<void> sendMessage({
    required String fromUid,
    required String toUid,
    required String messageText,
  });

  Future<void> createChat({
    required String createdByUid,
    required List<String> members,
    required String type,
    String? description,
    String? image,
    String? modifiedAt,
  });

  Future<void> updateChat({
    required String uid,
    required List<String> members,
  });
}
