import 'package:firebase_auth_app/features/chat/domain/domain.dart';
import 'package:firebase_auth_app/presentation/params/params.dart';

import '../../../core/core.dart';
import '../../../features/authentication/authentication.dart';

class ChatViewModel extends ViewModel {
  ChatViewModel(
    this._sendMessageUseCase,
    this._authRepository,
    this._createChannelUseCase,
  );

  final CreateOrListenToMessagesByChannelUseCase _createChannelUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final AuthenticationRepository _authRepository;

  final String _currentChannelId = '';
  String get currentUserId => _authRepository.userSnapshot!.uid;

  Stream<List<MessageModel>> messagesByChannel(
    String? channelId,
    ChannelParams? params,
  ) {
    return _createChannelUseCase(
      CreateChannelParams(
        currentUserId: currentUserId,
        members: params?.members,
        type: params?.type,
        currentChannelId: channelId,
        name: params?.name,
        description: params?.description,
        image: params?.image,
      ),
    );
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
