library;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/conversation.dart';
import '../repositories/chat_repository.dart';

class GetCachedConversationOnly
    implements
        UseCase<Conversation?, ({String userId, String conversationId})> {
  GetCachedConversationOnly(this._repository);

  final ChatRepository _repository;

  @override
  Future<({Failure? failure, Conversation? data})> call(
    ({String userId, String conversationId}) params,
  ) async {
    return _repository.getCachedConversationOnly(
      params.userId,
      params.conversationId,
    );
  }
}
