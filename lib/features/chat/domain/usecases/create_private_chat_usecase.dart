import 'package:firebase_auth_app/features/chat/data/data.dart';
import 'package:firebase_auth_app/features/chat/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

class CreatePrivateChatUseCase {
  CreatePrivateChatUseCase(this._chatRepository);
  final ChatRepository _chatRepository;

  Stream<String> call(
    CreatePrivateChatParams params,
  ) {
    final members = [params.currentUserId, params.chattingWithId];

    return _chatRepository.getCurrentChannelOrNull(members).switchMap(
      (channelId) {
        if (channelId == null) {
          return _chatRepository.createChannel(
            createdByUid: params.currentUserId,
            members: members,
            type: ChannelType.private.name,
          );
        }

        return Stream.value(channelId);
      },
    );
  }
}

class CreatePrivateChatParams {
  final String currentUserId;
  final String chattingWithId;

  CreatePrivateChatParams({
    required this.currentUserId,
    required this.chattingWithId,
  });
}

/// private: [LkXH8SjzdTd38SqZW4PDW3TnjqS2, aLcQeG1hzvS6GRLmr7vSbioyzCh2]
/// group: [LkXH8SjzdTd38SqZW4PDW3TnjqS2, aLcQeG1hzvS6GRLmr7vSbioyzCh2]
///
///