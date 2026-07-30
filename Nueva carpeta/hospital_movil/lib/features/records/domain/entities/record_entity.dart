import 'package:equatable/equatable.dart';

class RecordEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int? assignmentsId;

  const RecordEntity({
    required this.id,
    required this.name,
    required this.description,
    this.assignmentsId,
  });

  @override
  List<Object?> get props => [id, name, description, assignmentsId];
}
