import 'package:firebase_auth_app/core/core.dart';
import 'package:firebase_auth_app/features/chat/chat.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class SendMessageUseCase {
  final ChatRepository _repository;
  SendMessageUseCase(this._repository);

  Future<Result<Unit, AppFailure>> call(SendMessageParams params) async {
    try {
      _repository.sendMessage(
        channelId: params.channelId,
        sentBy: params.messageFrom,
        messageText: params.message,
      );

      return successOf(unit);
    } catch (_) {
      return failureOf(GenericFailure());
    }
  }
}

class SendMessageParams {
  final String message;
  final String channelId;
  final String messageFrom;

  SendMessageParams({
    required this.message,
    required this.channelId,
    required this.messageFrom,
  });
}
