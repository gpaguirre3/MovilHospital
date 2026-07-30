import '../../../../core/usecase/usecase.dart';
import '../entities/auth_session.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Result<AuthSession>> login({
    required String username,
    required String password,
  });

  Future<Result<void>> logout();

  Future<Result<User?>> getCurrentUser();
}
