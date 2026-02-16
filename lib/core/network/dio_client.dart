library;

import 'package:dio/dio.dart';

import '../../config/constants/api_constants.dart';
import 'api_interceptor.dart';

class DioClient {
  DioClient(
    this._dio, {
    String? baseUrl,
    Future<String?> Function()? tokenGetter,
  }) {
    _dio
      ..options.baseUrl = baseUrl ?? ApiConstants.baseUrl
      ..options.connectTimeout = ApiConstants.connectTimeout
      ..options.receiveTimeout = ApiConstants.receiveTimeout
      ..options.sendTimeout = ApiConstants.sendTimeout
      ..interceptors.addAll([
        LoggingInterceptor(),
        RetryInterceptor(dio: _dio),
        if (tokenGetter != null) AuthInterceptor(tokenGetter),
        CacheInterceptor(maxAge: const Duration(minutes: 5)),
      ]);
  }

  final Dio _dio;

  Dio get dio => _dio;
}
