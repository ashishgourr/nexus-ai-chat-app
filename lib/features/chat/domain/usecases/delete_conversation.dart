library;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/chat_repository.dart';

class DeleteConversation
    implements UseCase<void, ({String userId, String conversationId})> {
  DeleteConversation(this._repository);

  final ChatRepository _repository;

  @override
  Future<({Failure? failure, void data})> call(
    ({String userId, String conversationId}) params,
  ) async {
    return _repository.deleteConversation(params.userId, params.conversationId);
  }
}
