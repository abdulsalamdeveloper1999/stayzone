import 'package:injectable/injectable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class SignUpUsingEmail implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository authRepository;
  const SignUpUsingEmail(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await authRepository.signUpWithEmail(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String? name;
  const SignUpParams({required this.email, required this.password, this.name});
}
