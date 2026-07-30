import 'dart:convert';
import '../../../../core/storage/local_storage.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorage localStorage;

  static const String _keyToken = 'AUTH_TOKEN';
  static const String _keyUser = 'AUTH_USER';

  AuthLocalDataSourceImpl(this.localStorage);

  @override
  Future<void> saveToken(String token) async {
    await localStorage.write(_keyToken, token);
  }

  @override
  Future<String?> getToken() async {
    return await localStorage.read(_keyToken);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await localStorage.write(_keyUser, jsonEncode(user.toJson()));
  }

  @override
  Future<UserModel?> getUser() async {
    final rawUser = await localStorage.read(_keyUser);
    if (rawUser != null && rawUser.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(rawUser));
    }
    return null;
  }

  @override
  Future<void> clearSession() async {
    await localStorage.delete(_keyToken);
    await localStorage.delete(_keyUser);
  }
}
