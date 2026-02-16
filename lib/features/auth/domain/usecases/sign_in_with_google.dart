library;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogle implements UseCase<User?, NoParams> {
  SignInWithGoogle(this._repository);

  final AuthRepository _repository;

  @override
  Future<({Failure? failure, User? data})> call(NoParams params) async {
    return _repository.signInWithGoogle();
  }
}
