import '../../chat.dart';
import '../../data/mappers/mappers.dart';

class GetChannelsByUserUseCase {
  GetChannelsByUserUseCase(this._repository);
  final ChatRepository _repository;

  Stream<List<ChannelModel>> call(String userId) {
    return _repository
        .getChannelsByUserId(userId)
        .map((data) => ChatDataMapper.toChannelDomainList(data));
  }
}
