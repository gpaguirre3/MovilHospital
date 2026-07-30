import '../../domain/entities/assignment.dart';

class AssignmentModel extends Assignment {
  const AssignmentModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['assignmentsId'] as int? ?? 0,
      name: json['assignmentsName'] as String? ?? 'ASIGNACIÓN GENERAL',
      description: json['assignmentsDescription'] as String? ?? 'Registro de actividad',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assignmentsId': id,
      'assignmentsName': name,
      'assignmentsDescription': description,
    };
  }
}
