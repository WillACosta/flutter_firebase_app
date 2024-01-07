import 'package:firebase_auth_app/core/core.dart';
import 'package:flutter/foundation.dart';

abstract class ViewModel {
  final ValueNotifier<UiState> uiState = ValueNotifier(UiState.idle);
  void setState(UiState state) => uiState.value = state;
}
