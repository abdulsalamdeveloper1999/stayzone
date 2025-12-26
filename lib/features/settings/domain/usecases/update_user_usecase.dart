import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateUser implements UseCase<void, UserEntity> {
  final AuthRepository authRepository;

  const UpdateUser(this.authRepository);

  @override
  Future<Either<Failure, void>> call(UserEntity params) async {
    return await authRepository.updateUser(params);
  }
}
