import 'package:equatable/equatable.dart';
import '../../domain/entities/assignment.dart';

class AssignmentsState extends Equatable {
  final bool isLoading;
  final List<Assignment> assignments;
  final String? errorMessage;

  const AssignmentsState({
    this.isLoading = false,
    this.assignments = const [],
    this.errorMessage,
  });

  AssignmentsState copyWith({
    bool? isLoading,
    List<Assignment>? assignments,
    String? errorMessage,
  }) {
    return AssignmentsState(
      isLoading: isLoading ?? this.isLoading,
      assignments: assignments ?? this.assignments,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, assignments, errorMessage];
}
