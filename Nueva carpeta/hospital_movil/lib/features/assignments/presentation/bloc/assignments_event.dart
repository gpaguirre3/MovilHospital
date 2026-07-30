import 'package:equatable/equatable.dart';

abstract class AssignmentsEvent extends Equatable {
  const AssignmentsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAssignmentsRequested extends AssignmentsEvent {}
