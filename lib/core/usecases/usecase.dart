library;

import '../error/failures.dart';

class NoParams {
  const NoParams();
}

abstract class UseCase<T, Params> {
  /// Executes the use case.
  ///
  /// Returns a record with [failure] set on error, or [data] on success.
  Future<({Failure? failure, T? data})> call(Params params);
}
