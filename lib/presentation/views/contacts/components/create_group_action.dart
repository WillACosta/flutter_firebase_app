import 'package:flutter/material.dart';

class CreateGroupAction extends StatelessWidget {
  final void Function()? onCreateGroup;
  const CreateGroupAction({super.key, this.onCreateGroup});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.group),
          title: const Text('New Group'),
          onTap: onCreateGroup,
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
      ],
    );
  }
}
