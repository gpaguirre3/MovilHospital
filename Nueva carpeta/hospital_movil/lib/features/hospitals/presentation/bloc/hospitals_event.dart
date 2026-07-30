import 'package:equatable/equatable.dart';

abstract class HospitalsEvent extends Equatable {
  const HospitalsEvent();

  @override
  List<Object?> get props => [];
}

class FetchHospitalsRequested extends HospitalsEvent {}

class SearchQueryChanged extends HospitalsEvent {
  final String query;
  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class ToggleHospitalSelection extends HospitalsEvent {
  final int hospitalId;
  const ToggleHospitalSelection(this.hospitalId);

  @override
  List<Object?> get props => [hospitalId];
}

class ToggleSelectAllRequested extends HospitalsEvent {}

class ClearSearchRequested extends HospitalsEvent {}

class AssignHospitalsRequested extends HospitalsEvent {
  final int assignmentsId;
  final int? personId;

  const AssignHospitalsRequested({
    required this.assignmentsId,
    this.personId,
  });

  @override
  List<Object?> get props => [assignmentsId, personId];
}
