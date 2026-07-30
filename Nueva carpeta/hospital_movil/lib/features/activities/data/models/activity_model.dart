import '../../domain/entities/activity_entity.dart';

class ActivityModel extends ActivityEntity {
  const ActivityModel({
    required super.id,
    super.recordId,
    required super.name,
    required super.description,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    final parsedName = json['activityName'] as String? ??
        json['activityname'] as String? ??
        json['subactivityName'] as String? ??
        'Actividad #${json['activityId']}';

    final parsedDesc = json['activityDescription'] as String? ??
        json['activitydescription'] as String? ??
        json['subactivityDescription'] as String? ??
        '';

    return ActivityModel(
      id: json['activityId'] as int? ?? 0,
      recordId: json['recordId'] as int? ?? json['recordid'] as int?,
      name: parsedName,
      description: parsedDesc,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activityId': id,
      'recordId': recordId,
      'activityName': name,
      'activityDescription': description,
    };
  }
}

class SubactivityModel extends SubactivityEntity {
  const SubactivityModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory SubactivityModel.fromJson(Map<String, dynamic> json) {
    final parsedName = json['subactivityName'] as String? ??
        json['subactivityname'] as String? ??
        'Subactividad #${json['subactivityId']}';

    final parsedDesc = json['subactivityDescription'] as String? ??
        json['subactivitydescription'] as String? ??
        '';

    return SubactivityModel(
      id: json['subactivityId'] as int? ?? 0,
      name: parsedName,
      description: parsedDesc,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subactivityId': id,
      'subactivityName': name,
      'subactivityDescription': description,
    };
  }
}
