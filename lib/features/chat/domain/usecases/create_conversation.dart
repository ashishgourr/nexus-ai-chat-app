library;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/conversation.dart';
import '../repositories/chat_repository.dart';

class CreateConversation implements UseCase<Conversation?, String> {
  CreateConversation(this._repository);

  final ChatRepository _repository;

  @override
  Future<({Failure? failure, Conversation? data})> call(String params) async {
    return _repository.createConversation(params);
  }
}
