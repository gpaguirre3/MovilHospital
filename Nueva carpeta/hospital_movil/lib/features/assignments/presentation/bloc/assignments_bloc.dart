import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/assignment.dart';
import '../../domain/usecases/get_assignments_usecase.dart';
import 'assignments_event.dart';
import 'assignments_state.dart';

class AssignmentsBloc extends Bloc<AssignmentsEvent, AssignmentsState> {
  final GetAssignmentsUseCase getAssignmentsUseCase;

  AssignmentsBloc({required this.getAssignmentsUseCase})
      : super(const AssignmentsState()) {
    on<FetchAssignmentsRequested>(_onFetchAssignmentsRequested);
  }

  Future<void> _onFetchAssignmentsRequested(
    FetchAssignmentsRequested event,
    Emitter<AssignmentsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await getAssignmentsUseCase(NoParams());

    if (result is Success<List<Assignment>>) {
      emit(state.copyWith(
        isLoading: false,
        assignments: result.data,
      ));
    } else if (result is Error<List<Assignment>>) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.failure.message,
      ));
    }
  }
}
