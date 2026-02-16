library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/di/injection_container.dart';
import 'core/network/connectivity_overlay.dart';
import 'core/shell/authenticated_chat_shell.dart';
import 'core/utils/constants.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/chat/presentation/bloc/chat_detail/chat_detail_bloc.dart';
import 'features/chat/presentation/bloc/chat_detail/chat_detail_event.dart';
import 'features/chat/presentation/pages/chat_detail_page.dart';
import 'features/chat/presentation/pages/chat_list_page.dart';

GoRouter createAppRouter({
  required bool Function() isAuthenticated,
  required Widget Function() splashScreenBuilder,
}) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (BuildContext context, GoRouterState state) {
      final isAuth = isAuthenticated();
      final isGoingToAuth = state.matchedLocation == AppRoutes.auth;
      final isGoingToSplash = state.matchedLocation == AppRoutes.splash;

      if (isGoingToSplash) return null;
      if (!isAuth && !isGoingToAuth) return AppRoutes.auth;
      if (isAuth && isGoingToAuth) return AppRoutes.chats;
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) =>
            ConnectivityOverlay(child: splashScreenBuilder()),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (BuildContext context, GoRouterState state) =>
            const ConnectivityOverlay(child: AuthPage()),
      ),
      GoRoute(
        path: AppRoutes.chats,
        builder: (BuildContext context, GoRouterState state) =>
            ConnectivityOverlay(
              child: AuthenticatedChatShell(
                builder: (context, userId) => ChatListPage(userId: userId),
              ),
            ),
        routes: <RouteBase>[
          GoRoute(
            path: ':${AppRoutes.conversationIdParam}',
            builder: (BuildContext context, GoRouterState state) {
              final conversationId =
                  state.pathParameters[AppRoutes.conversationIdParam] ?? '';
              return ConnectivityOverlay(
                child: AuthenticatedChatShell(
                  builder: (context, userId) {
                    return BlocProvider(
                      create: (_) {
                        final bloc = sl.get<ChatDetailBloc>();
                        bloc.add(
                          ChatDetailEvent.loadRequested(
                            userId: userId,
                            conversationId: conversationId,
                          ),
                        );
                        return bloc;
                      },
                      child: ChatDetailPage(
                        conversationId: conversationId,
                        userId: userId,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
