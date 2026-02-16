library;

import 'package:flutter/material.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/security/input_sanitizer.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key, required this.onSend, this.enabled = true});

  final void Function(String text) onSend;

  final bool enabled;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.removeListener(() => setState(() {}));
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final raw = _controller.text.trim();
    if (raw.isEmpty) return;
    final sanitized = InputSanitizer.sanitizeString(raw);
    if (sanitized.isEmpty) return;
    widget.onSend(sanitized);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final hasText = _controller.text.trim().isNotEmpty;
    final canSend = widget.enabled && hasText;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppTheme.md + padding.left,
            AppTheme.md,
            AppTheme.md + padding.right,
            AppTheme.md + padding.bottom,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: AppTheme.primary),
                  onPressed: widget.enabled ? () {} : null,
                ),
              ),
              const SizedBox(width: AppTheme.sm),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  ),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    enabled: widget.enabled,
                    maxLines: 4,
                    minLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: AppStrings.askMeAnything,
                      hintStyle: const TextStyle(color: AppTheme.textTertiary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.md,
                        vertical: AppTheme.sm,
                      ),
                      filled: true,
                      fillColor: AppTheme.background,
                    ),
                    onSubmitted: (_) => _submit(),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.sm),
              Container(
                decoration: BoxDecoration(
                  gradient: canSend ? AppTheme.primaryGradient : null,
                  color: canSend ? null : AppTheme.divider,
                  shape: BoxShape.circle,
                ),
                child: Semantics(
                  label: canSend
                      ? AppStrings.sendMessage
                      : AppStrings.sendDisabledWhileAiResponding,
                  button: true,
                  enabled: canSend,
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                    onPressed: canSend ? _submit : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
