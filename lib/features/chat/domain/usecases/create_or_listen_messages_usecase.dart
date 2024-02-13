import 'package:firebase_auth_app/features/chat/data/mappers/mappers.dart';
import 'package:rxdart/rxdart.dart';

import '../../../authentication/authentication.dart';
import '../../chat.dart';

class CreateOrListenToMessagesByChannelUseCase {
  final CreatePrivateChatUseCase _createPrivateChatUseCase;
  final CreateGroupChannelUseCase _createGroupChannelUseCase;
  final ChatRepository _repository;

  CreateOrListenToMessagesByChannelUseCase(
    this._createPrivateChatUseCase,
    this._createGroupChannelUseCase,
    this._repository,
  );

  Stream<List<MessageModel>> call(CreateChannelParams params) {
    final members = params.members;

    if (params.currentChannelId != null) {
      return _getMessagesByChannelId(params.currentChannelId!);
    }

    if (params.type == ChannelType.private) {
      return _createPrivateChatUseCase(
        CreatePrivateChatParams(
          currentUserId: params.currentUserId,
          chattingWithId: members!.first.id,
        ),
      ).switchMap(_getMessagesByChannelId);
    }

    return _createGroupChannelUseCase(params)
        .switchMap(_getMessagesByChannelId);
  }

  Stream<List<MessageModel>> _getMessagesByChannelId(String id) {
    return _repository
        .getMessagesByChatId(id)
        .map((data) => ChatDataMapper.toMessageDomainList(data));
  }
}

class CreateChannelParams {
  final String currentUserId;
  final String? currentChannelId;
  final ChannelType? type;
  final List<UserModel>? members;
  final String? name;
  final String? description;
  final String? image;

  CreateChannelParams({
    required this.currentUserId,
    required this.members,
    this.type = ChannelType.private,
    this.currentChannelId,
    this.name,
    this.description,
    this.image,
  });

  CreateChannelParams copyWith({
    String? currentUserId,
    ChannelType? type,
    List<UserModel>? members,
    String? name,
    String? description,
    String? image,
  }) {
    return CreateChannelParams(
      currentUserId: currentUserId ?? this.currentUserId,
      type: type ?? this.type,
      members: members ?? this.members,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }
}
