library;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/conversation.dart';
import '../repositories/chat_repository.dart';

class GetConversation
    implements
        UseCase<Conversation?, ({String userId, String conversationId})> {
  GetConversation(this._repository);

  final ChatRepository _repository;

  @override
  Future<({Failure? failure, Conversation? data})> call(
    ({String userId, String conversationId}) params,
  ) async {
    return _repository.getConversation(params.userId, params.conversationId);
  }
}
