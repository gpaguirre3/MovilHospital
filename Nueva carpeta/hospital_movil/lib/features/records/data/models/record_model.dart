import '../../domain/entities/record_entity.dart';

class RecordModel extends RecordEntity {
  const RecordModel({
    required super.id,
    required super.name,
    required super.description,
    super.assignmentsId,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      id: json['recordId'] as int? ?? 0,
      name: json['recordName'] as String? ?? 'REGISTRO',
      description: json['recordDescription'] as String? ?? '',
      assignmentsId: json['assignmentsId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recordId': id,
      'recordName': name,
      'recordDescription': description,
      'assignmentsId': assignmentsId,
    };
  }
}
