library;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/conversation.dart';
import '../repositories/chat_repository.dart';

class GetCachedConversationsOnly
    implements UseCase<List<Conversation>, String> {
  GetCachedConversationsOnly(this._repository);

  final ChatRepository _repository;

  @override
  Future<({Failure? failure, List<Conversation>? data})> call(
    String params,
  ) async {
    return _repository.getCachedConversationsOnly(params);
  }
}
