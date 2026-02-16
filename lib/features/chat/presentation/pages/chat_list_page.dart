library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/responsive.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../domain/entities/conversation.dart';
import '../bloc/chat_list/chat_list_bloc.dart';
import '../bloc/chat_list/chat_list_event.dart';
import '../bloc/chat_list/chat_list_state.dart';
import '../widgets/empty_chat_state.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key, required this.userId});

  final String userId;

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  String? _lastShownAuthErrorMessage;

  void _showAuthErrorSnackBar(BuildContext context, String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.error,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ChatListBloc>().add(
            ChatListEvent.loadRequested(widget.userId),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (prev, curr) =>
          curr is AuthUnauthenticated || curr is AuthError,
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go(AppRoutes.auth);
        }
        if (state is AuthError && context.mounted) {
          _lastShownAuthErrorMessage = state.message;
          _showAuthErrorSnackBar(context, state.message);
        }
      },
      buildWhen: (prev, curr) => curr is AuthError || prev is AuthError,
      builder: (context, authState) {
        if (authState is AuthError &&
            authState.message != _lastShownAuthErrorMessage &&
            context.mounted) {
          _lastShownAuthErrorMessage = authState.message;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && context.mounted) {
              _showAuthErrorSnackBar(context, authState.message);
            }
          });
        }
        if (authState is! AuthError) {
          _lastShownAuthErrorMessage = null;
        }
        return Scaffold(
          backgroundColor: AppTheme.background,
          appBar: AppBar(
            title: const Text(AppStrings.chats),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (prev, curr) {
                  if (curr is! AuthAuthenticated) return false;
                  if (prev is! AuthAuthenticated) return true;
                  return prev.user.isAnonymous != curr.user.isAnonymous;
                },
                builder: (context, authState) {
                  final isGuest = authState is AuthAuthenticated && authState.user.isAnonymous;
                  return PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      switch (value) {
                        case 'link_google':
                          context.read<AuthBloc>().add(
                                const AuthEvent.linkWithGoogleRequested(),
                              );
                          break;
                        case 'link_apple':
                          context.read<AuthBloc>().add(
                                const AuthEvent.linkWithAppleRequested(),
                              );
                          break;
                        case 'sign_out':
                          context.read<AuthBloc>().add(
                                const AuthEvent.signOutRequested(),
                              );
                          break;
                      }
                    },
                    itemBuilder: (context) {
                      final items = <PopupMenuItem<String>>[];
                      if (isGuest) {
                        items.add(
                          const PopupMenuItem<String>(
                            value: 'link_google',
                            child: Row(
                              children: [
                                Icon(Icons.g_mobiledata, size: 20),
                                SizedBox(width: AppTheme.sm),
                                Text(AppStrings.linkToGoogle),
                              ],
                            ),
                          ),
                        );
                        if (Platform.isIOS || Platform.isMacOS) {
                          items.add(
                            const PopupMenuItem<String>(
                              value: 'link_apple',
                              child: Row(
                                children: [
                                  Icon(Icons.apple, size: 20),
                                  SizedBox(width: AppTheme.sm),
                                  Text(AppStrings.linkToApple),
                                ],
                              ),
                            ),
                          );
                        }
                      }
                      items.add(
                        const PopupMenuItem<String>(
                          value: 'sign_out',
                          child: Row(
                            children: [
                              Icon(Icons.logout, size: 20),
                              SizedBox(width: AppTheme.sm),
                              Text(AppStrings.signOut),
                            ],
                          ),
                        ),
                      );
                      return items;
                    },
                  );
                },
              ),
            ],
          ),
          body: BlocListener<ChatListBloc, ChatListState>(
          listenWhen: (prev, curr) =>
              curr is ChatListLoaded && curr.createdId != null,
          listener: (context, state) {
            if (state is ChatListLoaded && state.createdId != null) {
              context.push('${AppRoutes.chats}/${state.createdId}');
            }
          },
          child: BlocBuilder<ChatListBloc, ChatListState>(
            builder: (context, state) {
              if (state is ChatListLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ChatListError) {
                return Center(
                  child: Padding(
                    padding: Responsive.contentPadding(context),
                    child: Text(
                      state.message,
                      style: const TextStyle(color: AppTheme.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              if (state is ChatListLoaded) {
                if (state.conversations.isEmpty) {
                  return EmptyChatState(
                    onNewChat: () => context.read<ChatListBloc>().add(
                          ChatListEvent.createConversationRequested(widget.userId),
                        ),
                  );
                }
                return Responsive.constrainToMaxWidth(
                  context,
                  ListView.builder(
                    padding: EdgeInsets.only(
                      left: Responsive.horizontalPadding(context),
                      right: Responsive.horizontalPadding(context),
                      top: AppTheme.sm,
                      bottom: MediaQuery.paddingOf(context).bottom + 80,
                    ),
                    itemCount: state.conversations.length,
                    itemBuilder: (context, index) {
                      final conv = state.conversations[index];
                      return _ConversationCard(
                        conversation: conv,
                        userId: widget.userId,
                        onTap: () =>
                            context.push('${AppRoutes.chats}/${conv.id}'),
                      );
                    },
                  ),
                );
              }
              return const EmptyChatState(onNewChat: null);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.read<ChatListBloc>().add(
                  ChatListEvent.createConversationRequested(widget.userId),
                );
          },
          icon: const Icon(Icons.add),
          label: const Text(AppStrings.newChat),
          backgroundColor: AppTheme.primary,
          elevation: 4,
        ),
        );
      }
    );
  }
}

class _ConversationCard extends StatelessWidget {
  const _ConversationCard({
    required this.conversation,
    required this.userId,
    required this.onTap,
  });

  final Conversation conversation;
  final String userId;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.md,
        vertical: AppTheme.xs,
      ),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: () => _showDeleteDialog(context),
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.md),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppTheme.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conversation.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            _formatTimestamp(conversation.updatedAt),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textTertiary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.xs),
                      Text(
                        conversation.messages.isNotEmpty
                            ? conversation.messages.last.content
                            : AppStrings.noMessagesYet,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inMinutes < 1) return AppStrings.justNow;
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inDays < 1) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return DateFormat('MMM d').format(time);
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.deleteConversationTitle),
        content: const Text(
          AppStrings.deleteConversationContent,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(
              AppStrings.delete,
              style: TextStyle(color: AppTheme.error),
            ),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true && context.mounted) {
        context.read<ChatListBloc>().add(
              ChatListEvent.deleteConversationRequested(
                userId,
                conversation.id,
              ),
            );
      }
    });
  }
}
