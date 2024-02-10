import 'package:firebase_auth_app/features/chat/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/core.dart';
import '../../../features/authentication/authentication.dart';

class ChatViewModel extends ViewModel {
  ChatViewModel(
    this._createPrivateChatUseCase,
    this._getMessagesByChannelUseCase,
    this._sendMessageUseCase,
    this._authRepository,
  );

  final CreatePrivateChatUseCase _createPrivateChatUseCase;
  final GetMessagesByChannelUseCase _getMessagesByChannelUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final AuthenticationRepository _authRepository;

  String _currentChannelId = '';
  String get currentUserId => _authRepository.userSnapshot!.uid;

  Stream<List<MessageModel>> messagesByChannel(
    ChannelType type, {
    required List<UserModel> members,
  }) {
    /// TODO:
    /// move the logic for decide whether channel is PRIVATE or GROUP
    /// for the domain layer, such as use case like:
    /// CreateChannelUseCase(type, members)

    if (type == ChannelType.private) {
      return _createPrivateChatUseCase(
        CreatePrivateChatParams(
          currentUserId: currentUserId,
          chattingWithId: members.first.id,
        ),
      ).switchMap(
        (channelId) {
          _currentChannelId = channelId;
          return _getMessagesByChannelUseCase(channelId);
        },
      );
    }

    /// TODO: add later call for create a new GROUP or using existent
    return Stream.value([]);
  }

  Future<void> sendMessage(String message) async {
    await _sendMessageUseCase(
      SendMessageParams(
        channelId: _currentChannelId,
        messageFrom: currentUserId,
        message: message,
      ),
    );
  }
}
