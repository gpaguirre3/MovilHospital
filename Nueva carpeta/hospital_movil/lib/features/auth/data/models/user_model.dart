import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.username,
    required super.role,
    super.personId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      role: json['role'] ?? 'PATIENT',
      personId: json['personId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'role': role,
      'personId': personId,
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      username: user.username,
      role: user.role,
      personId: user.personId,
    );
  }
}
