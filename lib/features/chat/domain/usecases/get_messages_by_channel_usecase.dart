import 'package:firebase_auth_app/features/chat/data/mappers/mappers.dart';

import '../../chat.dart';

class GetMessagesByChannelUseCase {
  final ChatRepository _repository;
  GetMessagesByChannelUseCase(this._repository);

  Stream<List<MessageModel>> call(String channelId) async* {
    if (channelId.isEmpty) yield [];

    yield* _repository
        .getMessagesByChatId(channelId)
        .map((data) => ChatDataMapper.toMessageDomainList(data));
  }
}
