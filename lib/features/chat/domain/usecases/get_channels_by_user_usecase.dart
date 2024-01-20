import 'package:firebase_auth_app/features/chat/data/mappers/mappers.dart';

import '../../chat.dart';

/// TODO:
/// Make request for Channels of this user
/// Map them to ChannelDomain
/// Make request for each member and get details of it

class GetChannelsByUserUseCase {
  final ChatRepository _repository;
  GetChannelsByUserUseCase(this._repository);

  Stream<List<ChannelModel>> call(String userId) {
    return _repository
        .getChannelsByUserId(userId)
        .map((data) => ChatDataMapper.toChannelDomainList(data));
  }
}
