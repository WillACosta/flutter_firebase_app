import 'package:flutter/material.dart';

import '../../presentation/views/views.dart';

class RouteGenerator {
  static Route onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name;
    final args = settings.arguments;

    return switch (routeName) {
      '/' => MaterialPageRoute(builder: (_) => const SplashView()),
      '/signin' => MaterialPageRoute(builder: (_) => const SignInView()),
      '/home' => MaterialPageRoute(builder: (_) => const HomeView()),
      '/register' => MaterialPageRoute(builder: (_) => const RegisterView()),
      '/chat-conversation' => MaterialPageRoute(
          builder: (context) {
            final viewArgs = args as ChatConversationArgs;
            return ChatConversionView(args: viewArgs);
          },
        ),
      _ => MaterialPageRoute(builder: (_) => Container()),
    };
  }
}
