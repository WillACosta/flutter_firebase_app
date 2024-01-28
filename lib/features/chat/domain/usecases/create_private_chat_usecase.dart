import 'package:firebase_auth_app/features/chat/data/data.dart';
import 'package:firebase_auth_app/features/chat/domain/domain.dart';

class CreatePrivateChatUseCase {
  CreatePrivateChatUseCase(this._chatRepository);
  final ChatRepository _chatRepository;

  Stream<String> call(
    CreatePrivateChatParams params,
  ) {
    return _chatRepository.createChannel(
      createdByUid: params.currentUserId,
      members: [params.currentUserId, params.chattingWithId],
      type: ChannelType.private.name,
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
