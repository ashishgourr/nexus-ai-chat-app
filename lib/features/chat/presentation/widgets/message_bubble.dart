library;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final Message message;

  /// Max width as fraction of screen so bubbles don't stretch on tablets.
  static const double maxWidthFraction = 0.85;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == MessageRole.user;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPad = Responsive.horizontalPadding(context);
    final maxWidth = (screenWidth - horizontalPad * 2) * maxWidthFraction;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.md),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: AppTheme.sm),
          ],
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                crossAxisAlignment: isUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.md,
                      vertical: AppTheme.sm + 2,
                    ),
                    decoration: BoxDecoration(
                      gradient: isUser ? AppTheme.primaryGradient : null,
                      color: isUser ? null : AppTheme.aiBubble,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(AppTheme.radiusLg),
                        topRight: const Radius.circular(AppTheme.radiusLg),
                        bottomLeft: Radius.circular(
                          isUser ? AppTheme.radiusLg : 4,
                        ),
                        bottomRight: Radius.circular(
                          isUser ? 4 : AppTheme.radiusLg,
                        ),
                      ),
                      boxShadow: AppTheme.shadowSm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.content,
                          style: TextStyle(
                            fontSize: 15,
                            color: isUser
                                ? AppTheme.userBubbleText
                                : AppTheme.aiBubbleText,
                            height: 1.4,
                          ),
                        ),
                        if (message.status == MessageStatus.streaming) ...[
                          const SizedBox(height: AppTheme.xs),
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _TypingDot(delay: 0),
                              SizedBox(width: 4),
                              _TypingDot(delay: 150),
                              SizedBox(width: 4),
                              _TypingDot(delay: 300),
                            ],
                          ),
                        ],
                        if (message.status == MessageStatus.error &&
                            message.role == MessageRole.assistant) ...[
                          const SizedBox(height: AppTheme.xs),
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 14,
                                color: AppTheme.error,
                              ),
                              SizedBox(width: 4),
                              Text(
                                AppStrings.responseFailed,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.error,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.xs),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.xs,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatTime(message.createdAt),
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: AppTheme.sm),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: AppTheme.primary,
                size: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }
}

class _TypingDot extends StatefulWidget {
  const _TypingDot({required this.delay});

  final int delay;

  @override
  State<_TypingDot> createState() => _TypingDotState();
}

class _TypingDotState extends State<_TypingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 6,
        height: 6,
        decoration: const BoxDecoration(
          color: AppTheme.textTertiary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
