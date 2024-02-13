import 'package:firebase_auth_app/features/chat/chat.dart';

class CreateGroupChannelUseCase {
  final ChatRepository _chatRepository;
  CreateGroupChannelUseCase(this._chatRepository);

  Stream<String> call(CreateChannelParams params) {
    final membersId = params.members.map((e) => e.id).toList();

    return _chatRepository.createChannel(
      type: ChannelType.group.name,
      createdByUid: params.currentUserId,
      members: membersId,
      name: params.name,
      description: params.description,
      image: params.image,
    );
  }
}
