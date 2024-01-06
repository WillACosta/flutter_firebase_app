import 'package:flutter/material.dart';

extension AppSnackBar on BuildContext {
  void showSnackBar({
    required String? message,
    VoidCallback? onActionPressed,
    bool error = false,
  }) {
    final snackBar = SnackBar(
      backgroundColor: error ? Colors.red[300] : Colors.black54,
      content: Text(
        message ?? 'Oops! An error was occurred.',
      ),
      action: onActionPressed != null
          ? SnackBarAction(
              label: 'Ok',
              onPressed: onActionPressed,
            )
          : null,
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
