import 'package:firebase_auth_app/features/chat/domain/domain.dart';
import 'package:firebase_auth_app/presentation/params/params.dart';
import 'package:flutter/material.dart';

import '../../../features/authentication/authentication.dart';

class GroupCreationView extends StatefulWidget {
  final void Function(ChannelParams)? onCreateChannel;
  final List<UserModel> contacts;

  const GroupCreationView({
    super.key,
    required this.contacts,
    this.onCreateChannel,
  });

  @override
  State<GroupCreationView> createState() => _GroupCreationViewState();
}

class _GroupCreationViewState extends State<GroupCreationView> {
  List<bool?> checkboxValues = [];
  List<UserModel> selectedContacts = [];

  List<UserModel> get contacts => widget.contacts;
  bool get shouldDisableButton => checkboxValues.every((item) => item == false);

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _initGroupProperties();
    super.initState();
  }

  void _initGroupProperties() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    for (var _ in widget.contacts) {
      checkboxValues.add(false);
    }
  }

  void _updateCheckboxItem(bool? value, int index) {
    setState(() {
      checkboxValues[index] = value;

      if (value == true) {
        selectedContacts.add(contacts[index]);
      } else {
        selectedContacts.removeAt(index);
      }
    });
  }

  void _handleSubmitForm() {
    final formState = _formKey.currentState;
    final isValidForm = formState?.validate() ?? false;

    if (isValidForm && widget.onCreateChannel != null) {
      widget.onCreateChannel!.call(
        ChannelParams(
          type: ChannelType.group,
          members: selectedContacts,
          name: _nameController.text,
          description: _descriptionController.text,
        ),
      );
    }
  }

  String? _validateNameField(String? value) {
    if (value == null || value.isEmpty) {
      return 'required field';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Group Name',
              filled: true,
            ),
            validator: _validateNameField,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Group Description (optional)',
              filled: true,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: widget.contacts.length,
              itemBuilder: (_, index) {
                final user = contacts[index];

                return CheckboxListTile(
                  value: checkboxValues[index],
                  onChanged: (value) => _updateCheckboxItem(value, index),
                  title: Text(user.name),
                  subtitle: Text(
                    user.email,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: shouldDisableButton ? null : _handleSubmitForm,
            style: const ButtonStyle(
              elevation: MaterialStatePropertyAll(0),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Create')],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
