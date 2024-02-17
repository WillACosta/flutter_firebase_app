import 'package:firebase_auth_app/features/chat/domain/domain.dart';

import '../../../core/core.dart';
import '../../../features/authentication/authentication.dart';
import '../../params/params.dart';

class ChatViewModel extends ViewModel {
  ChatViewModel(
    this._sendMessageUseCase,
    this._authRepository,
    this._createChannelUseCase,
  );

  final CreateOrListenToMessagesByChannelUseCase _createChannelUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final AuthenticationRepository _authRepository;

  String currentChannelId = '';
  String get currentUserId => _authRepository.userSnapshot!.uid;

  Stream<List<MessageModel>> messagesByChannel(
    String? existingChannelId,
    ChannelUiParams? params,
  ) {
    return _createChannelUseCase(
      CreateChannelParams(
        currentUserId: currentUserId,
        members: params?.members,
        type: params?.type,
        currentChannelId: existingChannelId,
        name: params?.name,
        description: params?.description,
        image: params?.image,
      ),
      (id) => currentChannelId = id,
    );
  }

  Future<void> sendMessage(String message) async {
    await _sendMessageUseCase(
      SendMessageParams(
        channelId: currentChannelId,
        messageFrom: currentUserId,
        message: message,
      ),
    );
  }
}
