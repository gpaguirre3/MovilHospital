import 'package:equatable/equatable.dart';

class ActivityEntity extends Equatable {
  final int id;
  final int? recordId;
  final String name;
  final String description;

  const ActivityEntity({
    required this.id,
    this.recordId,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [id, recordId, name, description];
}

class SubactivityEntity extends Equatable {
  final int id;
  final String name;
  final String description;

  const SubactivityEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, description];
}
