library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/message.dart';
import '../bloc/chat_detail/chat_detail_bloc.dart';
import '../bloc/chat_detail/chat_detail_event.dart';
import '../bloc/chat_detail/chat_detail_state.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/message_bubble.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({
    super.key,
    required this.conversationId,
    required this.userId,
  });

  final String conversationId;
  final String userId;

  static const _rateLimitMessage = AppStrings.rateLimitMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.background,
      appBar: _buildAppBar(context),
      body: BlocListener<ChatDetailBloc, ChatDetailState>(
        listenWhen: (_, curr) =>
            curr is ChatDetailError && curr.message == _rateLimitMessage,
        listener: (context, state) {
          if (state is ChatDetailError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatDetailBloc, ChatDetailState>(
                builder: (context, state) {
                  final bottomPadding = MediaQuery.paddingOf(context).bottom;
                  final horizontalPad = Responsive.horizontalPadding(context);

                  if (state is ChatDetailLoading) {
                    return Center(
                      child: Semantics(
                        label: AppStrings.loadingMessages,
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is ChatDetailError) {
                    return Center(
                      child: Semantics(
                        label: 'Error: ${state.message}',
                        child: Padding(
                          padding: EdgeInsets.all(horizontalPad),
                          child: Text(
                            state.message,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is ChatDetailLoaded) {
                    if (state.messages.isEmpty) {
                      return _EmptyMessagesState(horizontalPad: horizontalPad);
                    }
                    return _MessageList(
                      messages: state.messages,
                      horizontalPad: horizontalPad,
                      bottomPadding: bottomPadding,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            BlocBuilder<ChatDetailBloc, ChatDetailState>(
              buildWhen: (prev, curr) {
                final prevStreaming =
                    prev is ChatDetailLoaded && prev.isStreaming;
                final currStreaming =
                    curr is ChatDetailLoaded && curr.isStreaming;
                return prevStreaming != currStreaming;
              },
              builder: (context, state) {
                final enabled = state is ChatDetailLoaded
                    ? !state.isStreaming
                    : true;
                return ChatInputField(
                  enabled: enabled,
                  onSend: (text) {
                    final message = Message(
                      id: const Uuid().v4(),
                      conversationId: conversationId,
                      role: MessageRole.user,
                      content: text,
                      createdAt: DateTime.now(),
                    );
                    context.read<ChatDetailBloc>().add(
                      ChatDetailEvent.sendMessage(
                        userId: userId,
                        conversationId: conversationId,
                        message: message,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: AppTheme.sm),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.aiAssistant,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  AppStrings.aiAssistantSubtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
      ],
    );
  }
}

class _MessageList extends StatefulWidget {
  const _MessageList({
    required this.messages,
    required this.horizontalPad,
    required this.bottomPadding,
  });

  final List<Message> messages;
  final double horizontalPad;
  final double bottomPadding;

  @override
  State<_MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<_MessageList> {
  final GlobalKey _lastMessageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToLastMessage();
    });
  }

  @override
  void didUpdateWidget(_MessageList oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldMessages = oldWidget.messages;
    final newMessages = widget.messages;
    if (newMessages.isEmpty) return;
    final lengthChanged = oldMessages.length != newMessages.length;
    final lastChanged =
        oldMessages.isEmpty ||
        oldMessages.last.id != newMessages.last.id ||
        oldMessages.last.content != newMessages.last.content;
    if (lengthChanged || lastChanged) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToLastMessage();
      });
    }
  }

  void _scrollToLastMessage() {
    final context = _lastMessageKey.currentContext;
    if (context != null && context.mounted) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        alignment: 1.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = widget.messages;
    final lastIndex = messages.length - 1;
    return ListView.builder(
      padding: EdgeInsets.only(
        left: widget.horizontalPad,
        right: widget.horizontalPad,
        top: AppTheme.sm,
        bottom: widget.bottomPadding + AppTheme.sm,
      ),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isLast = index == lastIndex;
        return MessageBubble(
          key: isLast ? _lastMessageKey : null,
          message: message,
        );
      },
    );
  }
}

class _EmptyMessagesState extends StatelessWidget {
  const _EmptyMessagesState({required this.horizontalPad});

  final double horizontalPad;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPad),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: AppTheme.shadowMd,
              ),
              child: const Icon(
                Icons.auto_awesome,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppTheme.xl),
            const Text(
              AppStrings.howCanIHelp,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.sm),
            const Text(
              AppStrings.sendMessageToStart,
              style: TextStyle(fontSize: 15, color: AppTheme.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
