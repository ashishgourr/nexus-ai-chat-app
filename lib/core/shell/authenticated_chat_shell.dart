library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_strings.dart';

import '../../config/theme/app_theme.dart';
import '../../features/auth/domain/entities/user.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../network/offline_sync_listener.dart';
import '../utils/constants.dart';

class AuthenticatedChatShell extends StatefulWidget {
  const AuthenticatedChatShell({super.key, required this.builder});

  final Widget Function(BuildContext context, String userId) builder;

  @override
  State<AuthenticatedChatShell> createState() => _AuthenticatedChatShellState();
}

class _AuthenticatedChatShellState extends State<AuthenticatedChatShell> {
  User? _lastAuthenticatedUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_maybeRedirect);
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      _lastAuthenticatedUser = authState.user;
      return OfflineSyncListener(
        userId: authState.user.id,
        child: widget.builder(context, authState.user.id),
      );
    }
    if (authState is AuthUnauthenticated) {
      _lastAuthenticatedUser = null;
      WidgetsBinding.instance.addPostFrameCallback(_maybeRedirect);
      return _loadingScaffold();
    }
    // AuthLoading or AuthError (e.g. during link): keep showing chat if we have a previous user
    if (_lastAuthenticatedUser != null) {
      return OfflineSyncListener(
        userId: _lastAuthenticatedUser!.id,
        child: widget.builder(context, _lastAuthenticatedUser!.id),
      );
    }
    WidgetsBinding.instance.addPostFrameCallback(_maybeRedirect);
    return _loadingScaffold();
  }

  Widget _loadingScaffold() {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: AppTheme.md),
            Text(
              AppStrings.signingIn,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _maybeRedirect(Duration _) {
    if (!context.mounted) return;
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) return;
    if ((authState is AuthLoading || authState is AuthError) &&
        _lastAuthenticatedUser != null) {
      return; // stay on chat; error is shown by ChatListPage SnackBar
    }
    context.go(AppRoutes.auth);
  }
}
