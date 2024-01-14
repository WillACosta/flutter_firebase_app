import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_app/features/chat/data/chat_repository.dart';

import '../domain/domain.dart';

class CChatRepository implements ChatRepository {
  CChatRepository(this._firestore);
  final FirebaseFirestore _firestore;

  @override
  Future<void> createChat({
    required String createdByUid,
    required List<String> members,
    required String type,
    String? description,
    String? image,
    String? modifiedAt,
  }) async {
    await _firestore.collection('groups').add({
      'createdBy': createdByUid,
      'type': type,
      'createdAt': DateTime.timestamp().toString(),
      'description': description,
      'image': image,
      'members': members
    });
  }

  @override
  Future<List<ChatModel>> getChatsByUser(String uid) async {
    final queryDocuments = await _firestore
        .collection('groups')
        .where('createdBy', isEqualTo: uid)
        .get();

    return queryDocuments.docs.map((e) => ChatModel.fromMap(e.data())).toList();
  }

  @override
  Future<List<MessageModel>> getMessagesByChatId(String uid) {
    // TODO: implement getMessagesByChatId
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage({
    required String fromUid,
    required String toUid,
    required String messageText,
  }) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  Future<void> updateChat(
      {required String uid, required List<String> members}) {
    // TODO: implement updateChat
    throw UnimplementedError();
  }
}
