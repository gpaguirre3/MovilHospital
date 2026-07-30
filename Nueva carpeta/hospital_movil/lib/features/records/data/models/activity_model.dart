class ActivityModel {
  final int id;
  final String name;
  final String description;

  const ActivityModel({
    required this.id,
    required this.name,
    required this.description,
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
      name: parsedName,
      description: parsedDesc,
    );
  }
}

class SubactivityModel {
  final int id;
  final String name;
  final String description;

  const SubactivityModel({
    required this.id,
    required this.name,
    required this.description,
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
}
