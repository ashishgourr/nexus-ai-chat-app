library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/responsive.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/apple_sign_in_button.dart';
import '../widgets/google_sign_in_button.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go(AppRoutes.chats);
            return;
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final padding = Responsive.horizontalPadding(context);
          final verticalPadding = Responsive.verticalPadding(context);
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: verticalPadding * 2,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.sizeOf(context).height -
                      MediaQuery.paddingOf(context).vertical -
                      verticalPadding * 4,
                ),
                child: Responsive.constrainToMaxWidth(
                  context,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppTheme.lg),
                      _buildHeroSection(),
                      const SizedBox(height: AppTheme.xxl),
                      const Text(
                        AppStrings.welcomeTitle,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppTheme.md),
                      const Text(
                        AppStrings.welcomeSubtitle,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: AppTheme.xxl),
                      const GoogleSignInButton(),
                      const SizedBox(height: AppTheme.md),
                      const AppleSignInButton(),
                      const SizedBox(height: AppTheme.md),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: AppTheme.divider,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.md,
                            ),
                            child: Text(
                              AppStrings.orDivider,
                              style: TextStyle(
                                color: AppTheme.textTertiary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: AppTheme.divider,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.md),
                      _GuestButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                const AuthEvent.signInAnonymousRequested(),
                              );
                        },
                      ),
                      const SizedBox(height: AppTheme.xl),
                      _buildFeatures(),
                      const SizedBox(height: AppTheme.lg),
                      Text(
                        AppStrings.termsAndPrivacy,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(AppTheme.lg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(AppTheme.radiusXl),
                boxShadow: AppTheme.shadowMd,
              ),
              child: const Icon(
                Icons.auto_awesome,
                size: 64,
                color: AppTheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures() {
    return Row(
      children: [
        Expanded(
          child: _FeatureItem(
            icon: Icons.speed,
            label: AppStrings.instantResponses,
          ),
        ),
        Expanded(
          child: _FeatureItem(
            icon: Icons.psychology,
            label: AppStrings.smartAi,
          ),
        ),
        Expanded(
          child: _FeatureItem(
            icon: Icons.chat_bubble_outline,
            label: AppStrings.alwaysHere,
          ),
        ),
      ],
    );
  }
}

class _GuestButton extends StatelessWidget {
  const _GuestButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.textPrimary,
        padding: const EdgeInsets.symmetric(vertical: 18),
        side: const BorderSide(color: AppTheme.divider, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline, size: 22),
          SizedBox(width: AppTheme.md),
          Text(
            AppStrings.continueAsGuest,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppTheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
          child: Icon(icon, color: AppTheme.primary, size: 28),
        ),
        const SizedBox(height: AppTheme.sm),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
