import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String role;
  final int? personId;

  const User({
    required this.username,
    required this.role,
    this.personId,
  });

  @override
  List<Object?> get props => [username, role, personId];
}
