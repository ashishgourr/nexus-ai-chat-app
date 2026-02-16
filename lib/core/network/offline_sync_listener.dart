library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../di/injection_container.dart';
import '../../features/chat/domain/usecases/flush_pending_messages.dart';
import 'connectivity_cubit.dart';

class OfflineSyncListener extends StatelessWidget {
  const OfflineSyncListener({
    super.key,
    required this.userId,
    required this.child,
  });

  final String userId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, bool>(
      listenWhen: (previous, current) => !previous && current,
      listener: (context, _) {
        sl.get<FlushPendingMessages>().call(userId);
      },
      child: child,
    );
  }
}
