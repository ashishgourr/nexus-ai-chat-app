library;

import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class AddPendingMessage {
  AddPendingMessage(this._repository);

  final ChatRepository _repository;

  Future<void> call(String userId, Message message) =>
      _repository.addPendingMessage(userId, message);
}
