import 'package:flutter/material.dart';

class ChatConversionView extends StatefulWidget {
  const ChatConversionView({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  State<ChatConversionView> createState() => _ChatConversionViewState();
}

class _ChatConversionViewState extends State<ChatConversionView> {
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
            TextField(
              decoration: InputDecoration(
                hintText: 'Type a message',
                suffixIcon: IconButton(
                  onPressed: () {},
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
