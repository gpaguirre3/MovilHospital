import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

class LoginUseCase implements UseCase<AuthSession, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Result<AuthSession>> call(LoginParams params) async {
    return await repository.login(
      username: params.username,
      password: params.password,
    );
  }
}
