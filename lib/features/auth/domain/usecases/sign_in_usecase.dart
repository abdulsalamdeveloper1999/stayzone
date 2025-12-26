import 'package:injectable/injectable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class SignInUsingEmail implements UseCase<UserEntity, SignInParams> {
  final AuthRepository authRepository;
  const SignInUsingEmail(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) async {
    return await authRepository.signInWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams {
  final String email;
  final String password;
  const SignInParams({required this.email, required this.password});
}
