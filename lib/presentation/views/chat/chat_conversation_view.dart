import 'package:firebase_auth_app/core/di/injection_container.dart';
import 'package:firebase_auth_app/presentation/params/params.dart';
import 'package:firebase_auth_app/presentation/views/chat/chat.dart';
import 'package:flutter/material.dart';

import '../../../features/authentication/authentication.dart';
import 'components/components.dart';

class ChatConversationArgs {
  final ChannelParams channelParams;
  ChatConversationArgs(this.channelParams);
}

class ChatConversionView extends StatefulWidget {
  const ChatConversionView({super.key, required this.args});
  final ChatConversationArgs args;

  @override
  State<ChatConversionView> createState() => _ChatConversionViewState();
}

class _ChatConversionViewState extends State<ChatConversionView> {
  final textController = TextEditingController();
  final vm = serviceLocator.get<ChatViewModel>();

  /// TODO: temporary
  /// Move this logic to the ViewModel
  UserModel get currentUser => widget.args.channelParams.members.first;

  void onSendMessage() {
    if (textController.text.isEmpty) return;
    vm.sendMessage(textController.text);
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(currentUser.name),
            Text(
              'last seen 19:32',
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontSize: 14,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StreamBuilder(
              stream: vm.messagesByChannel(widget.args.channelParams),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!;

                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        final currentMessage = messages[index];
                        return MessageBubble(
                          /// TODO: change this for using isCurrentUser
                          /// it'll be easier if we use the current user when
                          /// this is a GROUP of many people
                          isReceived: currentMessage.sentBy == currentUser.id,
                          message: currentMessage.messageText,
                        );
                      },
                      itemCount: messages.length,
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                suffixIcon: IconButton(
                  onPressed: onSendMessage,
                  icon: const Icon(Icons.send),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
