library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../config/constants/api_constants.dart';
import '../../error/exceptions.dart';

const String _geminiModel = 'gemini-3-flash-preview';

const String _baseHost = 'generativelanguage.googleapis.com';

Dio createGeminiDio() {
  return Dio(BaseOptions(
    connectTimeout: ApiConstants.geminiConnectTimeout,
    receiveTimeout: ApiConstants.geminiReceiveTimeout,
    sendTimeout: ApiConstants.geminiSendTimeout,
  ));
}

abstract class GeminiServiceInterface {
  Stream<String> generateStreamedResponse({
    required String message,
    required List<Content> conversationHistory,
  });
}

class GeminiService implements GeminiServiceInterface {
  GeminiService({
    String? apiKey,
    Dio? dio,
  })  : _apiKey = (apiKey ?? const String.fromEnvironment('GEMINI_API_KEY')).trim(),
        _dio = dio ?? createGeminiDio();

  final String _apiKey;
  final Dio _dio;

  static Future<String> _streamToString(Stream<dynamic> stream) async {
    final chunks = <List<int>>[];
    await for (final e in stream) {
      chunks.add(e is Uint8List ? e.toList() : e as List<int>);
    }
    return utf8.decode(chunks.expand((e) => e).toList());
  }

  @override
  Stream<String> generateStreamedResponse({
    required String message,
    required List<Content> conversationHistory,
  }) async* {
    if (_apiKey.isEmpty) {
      throw const AIServiceException('GEMINI_API_KEY is not set');
    }
    final contents = <Map<String, Object?>>[
      ...conversationHistory.map((c) => c.toJson()),
      Content.text(message).toJson(),
    ];
    final body = <String, Object?>{
      'contents': contents,
    };
    // v1beta streaming per quickstart; API key in header per docs.
    final uri = Uri.https(
      _baseHost,
      'v1beta/models/$_geminiModel:streamGenerateContent',
      {'alt': 'sse'},
    );
    try {
      final req = await _dio.postUri<ResponseBody>(
        uri,
        data: body,
        options: Options(
          responseType: ResponseType.stream,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            'x-goog-api-key': _apiKey,
          },
        ),
      );
      if (req.statusCode != 200) {
        final rawStream = req.data?.stream;
        final errBody = rawStream != null
            ? await _streamToString(rawStream)
            : '{}';
        final err = (jsonDecode(errBody) as Map<String, dynamic>?);
        final msg = err?['error']?['message'] ?? errBody;
        throw AIServiceException(msg is String ? msg : errBody);
      }
      final stream = req.data?.stream;
      if (stream == null) {
        throw const AIServiceException('No response stream');
      }
      final stringStream = stream.map<List<int>>((e) => List<int>.from(e));
      String accumulated = '';
      await for (final chunk in stringStream.transform(utf8.decoder).transform(const LineSplitter())) {
        const dataPrefix = 'data: ';
        if (chunk.startsWith(dataPrefix)) {
          final jsonText = chunk.substring(dataPrefix.length).trim();
          if (jsonText.isEmpty) continue;
          try {
            final map = jsonDecode(jsonText) as Map<String, dynamic>?;
            if (map == null) continue;
            final candidates = map['candidates'] as List<dynamic>?;
            final first = candidates?.isNotEmpty == true ? candidates!.first : null;
            final content = first is Map ? first['content'] : null;
            final parts = content is Map ? content['parts'] as List<dynamic>? : null;
            final part = parts?.isNotEmpty == true ? parts!.first : null;
            final text = part is Map ? part['text'] as String? : null;
            if (text != null && text.isNotEmpty) {
              accumulated += text;
              yield accumulated;
            }
          } catch (_) {
            // Skip malformed SSE lines
          }
        }
      }
    } on DioException catch (e) {
      final msg = e.response?.data is String
          ? e.response!.data as String
          : e.message ?? e.type.toString();
      throw AIServiceException(msg);
    } catch (e) {
      throw AIServiceException(e.toString());
    }
  }
}
