library;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class SignOut implements UseCase<void, NoParams> {
  SignOut(this._repository);

  final AuthRepository _repository;

  @override
  Future<({Failure? failure, void data})> call(NoParams params) async {
    return _repository.signOut();
  }
}
