import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';
import '../../../contacts/contacts.dart';
import '../models/models.dart';
import 'chat_repository.dart';

class CChatRepository implements ChatRepository {
  CChatRepository(this._firestore, this._contactsRepository);

  final FirebaseFirestore _firestore;
  final ContactsRepository _contactsRepository;

  @override
  Future<String> createChannel({
    required String createdByUid,
    required List<String> members,
    required String type,
    String? description,
    String? image,
    String? modifiedAt,
  }) async {
    final payload = {
      'createdBy': createdByUid,
      'type': type,
      'createdAt': DateTime.now().toIso8601String(),
      'description': description,
      'image': image,
      'members': members
    };

    final result =
        await _firestore.collection(DBCollection.channels).add(payload);

    final currentChannelId = result.id;
    await _updateChannelWithGeneratedUid(currentChannelId);

    return currentChannelId;
  }

  @override
  StreamListOf<NetworkChannel> getChannelsByUserId(String id) {
    return _firestore
        .collection(DBCollection.channels)
        .where('createdBy', isEqualTo: id)
        .snapshots()
        .map((response) => response.docs.map((e) => e.data()).toList())
        .switchMap(
          (channels) => Stream.fromFuture(_resolveMembersList(channels)),
        )
        .map(NetworkChannel.fromMapList);
  }

  @override
  StreamListOf<NetworkMessage> getMessagesByChatId(String id) {
    return _firestore
        .collection(DBCollection.chats)
        .doc(id)
        .collection(DBCollection.messages)
        .orderBy('sentAt')
        .snapshots()
        .map(NetworkMessage.fromFirestoreList);
  }

  @override
  Future<void> sendMessage({
    required String channelId,
    required String sentBy,
    required String messageText,
  }) async {
    final payload = {
      'sentBy': sentBy,
      'sentAt': DateTime.now().toIso8601String(),
      'messageText': messageText,
    };

    await _firestore
        .collection(DBCollection.chats)
        .doc(channelId)
        .collection(DBCollection.messages)
        .add(payload);
  }

  @override
  Future<void> deleteChannel(String channelId) {
    return _firestore.collection(DBCollection.channels).doc(channelId).delete();
  }

  Future<void> _updateChannelWithGeneratedUid(String channelId) async {
    _firestore
        .collection(DBCollection.channels)
        .doc(channelId)
        .update({'id': channelId});
  }

  AsyncMapList _resolveMembersList(
    List<Map<String, dynamic>> data,
  ) async {
    List<Map<String, dynamic>> result = [];

    for (var e in data) {
      final users = await _contactsRepository.getUsersByIdList(e['members']);
      e.update('members', (value) => users);
      result.add(e);
    }

    return result;
  }
}
