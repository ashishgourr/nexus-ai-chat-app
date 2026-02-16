library;

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityCubit extends Cubit<bool> {
  ConnectivityCubit(this._connectivity) : super(true) {
    _subscription = _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
    _connectivity.checkConnectivity().then(_setFromResult);
  }

  final Connectivity _connectivity;
  StreamSubscription<dynamic>? _subscription;

  static bool _resultToOnline(dynamic result) {
    final list = result is List<ConnectivityResult>
        ? result
        : [result as ConnectivityResult];
    return list.any(
      (r) =>
          r == ConnectivityResult.mobile ||
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.ethernet,
    );
  }

  void _setFromResult(dynamic result) {
    emit(_resultToOnline(result));
  }

  void _onConnectivityChanged(dynamic result) {
    _setFromResult(result);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
