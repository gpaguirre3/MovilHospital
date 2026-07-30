import 'package:equatable/equatable.dart';
import 'user.dart';

class AuthSession extends Equatable {
  final String token;
  final User user;
  final String? message;

  const AuthSession({
    required this.token,
    required this.user,
    this.message,
  });

  @override
  List<Object?> get props => [token, user, message];
}
