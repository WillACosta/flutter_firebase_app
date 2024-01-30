import 'package:firebase_auth_app/core/di/injection_container.dart';
import 'package:firebase_auth_app/presentation/views/chat/chat.dart';
import 'package:flutter/material.dart';

class ChatConversationArgs {
  final String chattingWithId;
  ChatConversationArgs({required this.chattingWithId});
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

  String get chattingWithId => widget.args.chattingWithId;

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
            const Text('Sêneca'),
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
              stream: vm.messagesByChannel(chattingWithId),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!;

                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        return Text(messages[index].messageText);
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
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
