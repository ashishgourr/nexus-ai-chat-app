library;

import '../error/failures.dart';

abstract class StreamUseCase<T, Params> {
  /// Executes the use case.
  ///
  /// Returns a stream of records with [failure] set on error, or [data] on success.
  Stream<({Failure? failure, T? data})> call(Params params);
}
