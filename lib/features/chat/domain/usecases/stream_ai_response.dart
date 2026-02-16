library;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/stream_usecase.dart';
import '../entities/message.dart';
import '../repositories/chat_repository.dart';

typedef StreamAIResponseParams = ({
  String conversationId,
  String message,
  List<Message> history,
});

class StreamAIResponse
    implements StreamUseCase<String, StreamAIResponseParams> {
  StreamAIResponse(this._repository);

  final ChatRepository _repository;

  @override
  Stream<({Failure? failure, String? data})> call(
    StreamAIResponseParams params,
  ) {
    return _repository.streamAIResponse(
      conversationId: params.conversationId,
      message: params.message,
      history: params.history,
    );
  }
}
