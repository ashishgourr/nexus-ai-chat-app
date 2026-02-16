library;

import 'package:dio/dio.dart';

import '../../config/constants/api_constants.dart';
import '../utils/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.d('REQUEST[${options.method}] ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.d(
      'RESPONSE[${response.statusCode}] ${response.requestOptions.uri}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e(
      'ERROR[${err.response?.statusCode}] ${err.requestOptions.uri}',
      error: err,
    );
    handler.next(err);
  }
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenGetter);

  final Future<String?> Function() _tokenGetter;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenGetter();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

class CacheEntry {
  CacheEntry({required this.data, required this.timestamp, this.maxAge});

  final dynamic data;
  final DateTime timestamp;
  final Duration? maxAge;

  bool get isExpired {
    if (maxAge == null) return false;
    return DateTime.now().difference(timestamp) > maxAge!;
  }
}

class CacheInterceptor extends Interceptor {
  CacheInterceptor({this.maxAge = const Duration(minutes: 5)});

  final Duration maxAge;
  final Map<String, CacheEntry> _cache = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method == 'GET') {
      final cacheKey = options.uri.toString();
      final cached = _cache[cacheKey];
      if (cached != null && !cached.isExpired) {
        return handler.resolve(
          Response(requestOptions: options, data: cached.data, statusCode: 304),
        );
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.method == 'GET' && response.statusCode == 200) {
      final cacheKey = response.requestOptions.uri.toString();
      _cache[cacheKey] = CacheEntry(
        data: response.data,
        timestamp: DateTime.now(),
        maxAge: maxAge,
      );
    }
    handler.next(response);
  }
}

class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    this.maxRetries = ApiConstants.maxRetries,
    this.baseDelay = ApiConstants.retryDelay,
  });

  final Dio dio;
  final int maxRetries;
  final Duration baseDelay;

  static bool _shouldRetry(DioException err) {
    if (err.response != null) {
      final code = err.response!.statusCode ?? 0;
      if (code >= 400 && code < 500) return false;
    }
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError;
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldRetry(err) || (err.requestOptions.extra['retry'] as int? ?? 0) >= maxRetries) {
      return handler.next(err);
    }
    final attempt = (err.requestOptions.extra['retry'] as int? ?? 0) + 1;
    final delay = Duration(
      milliseconds: baseDelay.inMilliseconds * (1 << (attempt - 1)),
    );
    AppLogger.d('Retry $attempt/$maxRetries after ${delay.inMilliseconds}ms');
    await Future<void>.delayed(delay);
    final opts = err.requestOptions;
    opts.extra['retry'] = attempt;
    try {
      final response = await dio.fetch(opts);
      return handler.resolve(response);
    } catch (_) {
      return handler.next(err);
    }
  }
}
