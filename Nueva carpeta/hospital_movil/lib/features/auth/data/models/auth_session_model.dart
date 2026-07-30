import '../../domain/entities/auth_session.dart';
import 'user_model.dart';

class AuthSessionModel extends AuthSession {
  const AuthSessionModel({
    required super.token,
    required super.user,
    super.message,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      token: json['token'] ?? '',
      user: UserModel.fromJson(json),
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'username': user.username,
      'role': user.role,
      'personId': user.personId,
      'message': message,
    };
  }
}
