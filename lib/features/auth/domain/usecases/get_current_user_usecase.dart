import 'package:injectable/injectable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class GetCurrentUser implements UseCase<UserEntity?, NoParams> {
  final AuthRepository authRepository;
  const GetCurrentUser(this.authRepository);

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }
}
