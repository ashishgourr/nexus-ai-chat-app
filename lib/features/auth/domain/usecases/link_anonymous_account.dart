library;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LinkAnonymousAccount implements UseCase<User?, LinkProvider> {
  LinkAnonymousAccount(this._repository);

  final AuthRepository _repository;

  @override
  Future<({Failure? failure, User? data})> call(LinkProvider params) async {
    return _repository.linkAnonymousAccount(params);
  }
}
