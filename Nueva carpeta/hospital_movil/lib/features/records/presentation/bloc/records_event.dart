import 'package:equatable/equatable.dart';

abstract class RecordsEvent extends Equatable {
  const RecordsEvent();

  @override
  List<Object?> get props => [];
}

class FetchRecordsRequested extends RecordsEvent {
  final int? assignmentId;

  const FetchRecordsRequested({this.assignmentId});

  @override
  List<Object?> get props => [assignmentId];
}
