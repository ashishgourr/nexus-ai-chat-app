library;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class SaveAssistantMessage
    implements UseCase<void, ({String userId, Message message})> {
  SaveAssistantMessage(this._repository);

  final ChatRepository _repository;

  @override
  Future<({Failure? failure, void data})> call(
    ({String userId, Message message}) params,
  ) async {
    return _repository.saveAssistantMessage(params.userId, params.message);
  }
}
