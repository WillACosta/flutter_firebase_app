import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.onTap,
  });

  final String title;
  final String description;
  final String? imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(60),
        ),
      ),
      title: Text(title),
      subtitle: Text(
        description,
        style: TextStyle(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}
