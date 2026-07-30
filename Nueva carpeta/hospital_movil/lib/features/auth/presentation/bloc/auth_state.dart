import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  final String token;
  final String? message;

  const AuthSuccess({
    required this.user,
    required this.token,
    this.message,
  });

  @override
  List<Object?> get props => [user, token, message];
}

class Unauthenticated extends AuthState {}

class AuthFailureState extends AuthState {
  final String message;

  const AuthFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
