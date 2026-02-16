library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme/app_theme.dart';
import '../constants/app_strings.dart';
import 'connectivity_cubit.dart';

class ConnectivityOverlay extends StatelessWidget {
  const ConnectivityOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, bool>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, isOnline) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isOnline ? AppStrings.backOnline : AppStrings.youreOffline,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: isOnline ? AppTheme.primary : AppTheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: BlocBuilder<ConnectivityCubit, bool>(
        builder: (context, isOnline) {
          if (isOnline) return child;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Material(
                color: AppTheme.error.withValues(alpha: 0.9),
                child: const SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.md,
                      vertical: AppTheme.sm,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cloud_off_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: AppTheme.sm),
                        Expanded(
                          child: Text(
                            AppStrings.noInternetConnection,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(child: child),
            ],
          );
        },
      ),
    );
  }
}
