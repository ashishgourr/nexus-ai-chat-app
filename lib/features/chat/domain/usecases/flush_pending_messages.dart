library;

import '../repositories/chat_repository.dart';

class FlushPendingMessages {
  FlushPendingMessages(this._repository);

  final ChatRepository _repository;

  Future<void> call(String userId) => _repository.flushPendingMessages(userId);
}
