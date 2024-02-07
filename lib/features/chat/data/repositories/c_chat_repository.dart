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
  Stream<String> createChannel({
    required String createdByUid,
    required List<String> members,
    required String type,
    String? description,
    String? image,
    String? modifiedAt,
  }) {
    final payload = {
      'createdBy': createdByUid,
      'type': type,
      'createdAt': DateTime.now().toIso8601String(),
      'description': description,
      'image': image,
      'members': members
    };

    return _firestore
        .collection(DBCollection.channels)
        .add(payload)
        .asStream()
        .switchMap(
      (result) {
        return Rx.combineLatest2(
          Stream.value(result.id),
          _updateChannelWithGeneratedUid(result.id),
          (channelId, _) => channelId,
        );
      },
    );
  }

  @override
  StreamListOf<NetworkChannel> getChannelsByUserId(String id) {
    return _firestore
        .collection(DBCollection.channels)
        .where('members', arrayContains: id)
        .snapshots()
        .map((response) {
          return response.docs.map((e) => e.data()).toList();
        })
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

  @override
  Stream<String?> getCurrentChannelOrNull(List<dynamic> ids) {
    final equality = const ListEquality().equals;

    return _firestore
        .collection(DBCollection.channels)
        .where('members', arrayContainsAny: ids)
        .snapshots()
        .map(
      (response) {
        final channels = response.docs.where((e) {
          final data = e.data();
          final members = data['members'];

          members.sort();
          ids.sort();
          return equality(members, ids);
        }).toList();

        if (channels.isEmpty) return null;
        return channels.first.id;
      },
    ).onErrorReturnWith((_, __) => null);
  }

  Stream<void> _updateChannelWithGeneratedUid(String channelId) {
    return _firestore
        .collection(DBCollection.channels)
        .doc(channelId)
        .update({'id': channelId}).asStream();
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
