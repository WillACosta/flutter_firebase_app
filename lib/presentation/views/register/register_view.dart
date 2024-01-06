import 'package:firebase_auth_app/core/core.dart';
import 'package:flutter/material.dart';

import 'register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final vm = serviceLocator.get<RegisterViewModel>();
  final formKey = GlobalKey<FormState>();

  void onSubmitForm() {
    formKey.currentState?.save();
    vm.submitForm();
  }

  void _navigateToSignIn() {
    Navigator.pushNamed(context, '/signin');
  }

  @override
  void initState() {
    _setListeners();
    super.initState();
  }

  _setListeners() {
    vm.uiState.addListener(() {
      if (vm.uiState.value == UiState.error) {
        context.showSnackBar(
          message: 'Oops! Email or Password invalid!',
          error: true,
        );
      }

      if (vm.uiState.value == UiState.success) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              TextFormField(
                initialValue: vm.email,
                onSaved: (value) => vm.setEmail(value),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'email',
                ),
              ),
              const SizedBox(height: 23),
              TextFormField(
                initialValue: vm.password,
                onSaved: (value) => vm.setPassword(value),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'password',
                ),
              ),
              const SizedBox(height: 45),
              ListenableBuilder(
                listenable: vm.uiState,
                builder: (_, __) {
                  if (vm.uiState.value == UiState.loading) {
                    return const CircularProgressIndicator();
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: onSubmitForm,
                        child: const Text('Register'),
                      ),
                      TextButton(
                        onPressed: _navigateToSignIn,
                        child: const Text('Sign in'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
