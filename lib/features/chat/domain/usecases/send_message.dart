library;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class SendMessage
    implements UseCase<Message?, ({String userId, Message message})> {
  SendMessage(this._repository);

  final ChatRepository _repository;

  @override
  Future<({Failure? failure, Message? data})> call(
    ({String userId, Message message}) params,
  ) async {
    return _repository.sendMessage(params.userId, params.message);
  }
}
