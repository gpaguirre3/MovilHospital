import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result<AuthSession>> login({
    required String username,
    required String password,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Error(NetworkFailure('No hay conexión a Internet'));
    }

    try {
      final sessionModel = await remoteDataSource.login(
        username: username,
        password: password,
      );

      // Save token and user info locally
      await localDataSource.saveToken(sessionModel.token);
      await localDataSource.saveUser(
        UserModel.fromEntity(sessionModel.user),
      );

      return Success(sessionModel);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await localDataSource.clearSession();
      return const Success(null);
    } catch (e) {
      return const Error(CacheFailure('Error al cerrar sesión local'));
    }
  }

  @override
  Future<Result<User?>> getCurrentUser() async {
    try {
      final user = await localDataSource.getUser();
      return Success(user);
    } catch (e) {
      return const Error(CacheFailure('Error al obtener usuario local'));
    }
  }
}
