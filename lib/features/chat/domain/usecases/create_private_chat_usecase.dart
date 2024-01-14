import 'package:firebase_auth_app/features/chat/data/data.dart';
import 'package:firebase_auth_app/features/chat/domain/domain.dart';

class CreatePrivateChatUseCase {
  CreatePrivateChatUseCase(this._chatRepository);
  final ChatRepository _chatRepository;

  Future<void> call(CreatePrivateChatParams params) async {
    _chatRepository.createChat(
      createdByUid: params.userId,
      members: [params.userId, params.secondPersonId],
      type: ChatType.private.name,
    );
  }
}

class CreatePrivateChatParams {
  final String userId;
  final String secondPersonId;

  CreatePrivateChatParams({
    required this.userId,
    required this.secondPersonId,
  });
}
