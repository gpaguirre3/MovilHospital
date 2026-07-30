import '../../../../core/network/dio_client.dart';
import '../models/auth_session_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login({
    required String username,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<AuthSessionModel> login({
    required String username,
    required String password,
  }) async {
    final response = await dioClient.post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
      },
    );

    return AuthSessionModel.fromJson(response.data);
  }
}
