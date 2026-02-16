library;

import 'package:flutter/material.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive.dart' show Breakpoint, Responsive;

class EmptyChatState extends StatelessWidget {
  const EmptyChatState({super.key, this.onNewChat});

  final VoidCallback? onNewChat;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final padding = Responsive.contentPadding(context);
    return Center(
      child: SingleChildScrollView(
        padding: padding,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: size.width > Breakpoint.maxContentWidth
                ? Breakpoint.maxContentWidth
                : double.infinity,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 80,
                    color: AppTheme.primary.withValues(alpha: 0.6),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.xl),
              const Text(
                AppStrings.noConversationsYet,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.sm),
              const Text(
                AppStrings.startConversationSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: AppTheme.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppTheme.xl),
              if (onNewChat != null)
                ElevatedButton.icon(
                  onPressed: onNewChat,
                  icon: const Icon(Icons.add),
                  label: const Text(AppStrings.startNewChat),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
              const SizedBox(height: AppTheme.lg),
              _SuggestionChips(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const suggestions = [
      ('💡', AppStrings.getIdeas),
      ('📝', AppStrings.writeContent),
      ('🤔', AppStrings.askQuestions),
      ('🎨', AppStrings.beCreative),
    ];
    return Wrap(
      spacing: AppTheme.sm,
      runSpacing: AppTheme.sm,
      alignment: WrapAlignment.center,
      children: suggestions.map((s) {
        return ActionChip(
          avatar: Text(s.$1, style: const TextStyle(fontSize: 16)),
          label: Text(s.$2),
          backgroundColor: AppTheme.background,
          side: const BorderSide(color: AppTheme.divider),
          onPressed: () {},
        );
      }).toList(),
    );
  }
}
