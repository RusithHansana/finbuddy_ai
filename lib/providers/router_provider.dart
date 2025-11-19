import 'package:finbuddy_ai/providers/auth_provider.dart';
import 'package:finbuddy_ai/screens/chat_screen.dart';
import 'package:finbuddy_ai/screens/history_screen.dart';
import 'package:finbuddy_ai/screens/settings_screen.dart';
import 'package:finbuddy_ai/screens/sign_in_screen.dart';
import 'package:finbuddy_ai/screens/sign_up_screen.dart';
import 'package:finbuddy_ai/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

// ============== ROUTE NAMES ==============

class Routes {
  static const String welcome = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String chat = '/chat';
  static const String history = '/history';
  static const String settings = '/settings';
}

// ============== ROUTER PROVIDER ==============

@riverpod
GoRouter router(Ref ref) {
  final authStateChanges = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: Routes.welcome,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = authStateChanges.when(
        data: (user) => user != null,
        loading: () => false,
        error: (_, __) => false,
      );
      final isAuthRoute = [
        Routes.welcome,
        Routes.signIn,
        Routes.signUp,
      ].contains(state.matchedLocation);

      // If not authenticated and trying to access protected route
      if (!isAuthenticated && !isAuthRoute) {
        return Routes.welcome;
      }

      // If authenticated and on auth routes, redirect to chat
      if (isAuthenticated && isAuthRoute) {
        return Routes.chat;
      }

      // No redirect needed
      return null;
    },
    routes: [
      // ========== PUBLIC ROUTES ==========
      GoRoute(
        path: Routes.welcome,
        name: 'welcome',
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: const WelcomeScreen()),
      ),
      GoRoute(
        path: Routes.signIn,
        name: 'signIn',
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: const SignInScreen()),
      ),
      GoRoute(
        path: Routes.signUp,
        name: 'signUp',
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: const SignUpScreen()),
      ),

      // ========== PROTECTED ROUTES ==========
      GoRoute(
        path: Routes.chat,
        name: 'chat',
        pageBuilder: (context, state) {
          final conversationId = state.uri.queryParameters['conversationId'];
          return MaterialPage(
            key: state.pageKey,
            child: ChatScreen(conversationId: conversationId),
          );
        },
      ),
      GoRoute(
        path: Routes.history,
        name: 'history',
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: const HistoryScreen()),
      ),
      GoRoute(
        path: Routes.settings,
        name: 'settings',
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: const SettingsScreen()),
      ),
    ],
  );
}
