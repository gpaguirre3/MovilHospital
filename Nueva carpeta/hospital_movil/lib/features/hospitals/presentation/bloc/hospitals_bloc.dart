import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/hospital.dart';
import '../../domain/usecases/get_hospitals_usecase.dart';
import '../../domain/usecases/update_hospital_assignment_usecase.dart';
import 'hospitals_event.dart';
import 'hospitals_state.dart';

class HospitalsBloc extends Bloc<HospitalsEvent, HospitalsState> {
  final GetHospitalsUseCase getHospitalsUseCase;
  final UpdateHospitalAssignmentUseCase updateHospitalAssignmentUseCase;

  HospitalsBloc({
    required this.getHospitalsUseCase,
    required this.updateHospitalAssignmentUseCase,
  }) : super(const HospitalsState()) {
    on<FetchHospitalsRequested>(_onFetchHospitalsRequested);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<ToggleHospitalSelection>(_onToggleHospitalSelection);
    on<ToggleSelectAllRequested>(_onToggleSelectAllRequested);
    on<ClearSearchRequested>(_onClearSearchRequested);
    on<AssignHospitalsRequested>(_onAssignHospitalsRequested);
  }

  Future<void> _onFetchHospitalsRequested(
    FetchHospitalsRequested event,
    Emitter<HospitalsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await getHospitalsUseCase(NoParams());

    if (result is Success<List<Hospital>>) {
      final hospitals = result.data;
      emit(state.copyWith(
        isLoading: false,
        allHospitals: hospitals,
        filteredHospitals: _applyFilter(hospitals, state.searchQuery),
      ));
    } else if (result is Error<List<Hospital>>) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.failure.message,
      ));
    }
  }

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<HospitalsState> emit,
  ) {
    final query = event.query;
    final filtered = _applyFilter(state.allHospitals, query);
    emit(state.copyWith(
      searchQuery: query,
      filteredHospitals: filtered,
    ));
  }

  void _onToggleHospitalSelection(
    ToggleHospitalSelection event,
    Emitter<HospitalsState> emit,
  ) {
    final newSelected = Set<int>.from(state.selectedIds);
    if (newSelected.contains(event.hospitalId)) {
      newSelected.remove(event.hospitalId);
    } else {
      newSelected.add(event.hospitalId);
    }

    emit(state.copyWith(selectedIds: newSelected));
  }

  void _onToggleSelectAllRequested(
    ToggleSelectAllRequested event,
    Emitter<HospitalsState> emit,
  ) {
    final newSelected = Set<int>.from(state.selectedIds);
    final currentlyFiltered = state.filteredHospitals;

    if (state.isAllSelected) {
      for (final h in currentlyFiltered) {
        newSelected.remove(h.id);
      }
    } else {
      for (final h in currentlyFiltered) {
        newSelected.add(h.id);
      }
    }

    emit(state.copyWith(selectedIds: newSelected));
  }

  void _onClearSearchRequested(
    ClearSearchRequested event,
    Emitter<HospitalsState> emit,
  ) {
    emit(state.copyWith(
      searchQuery: '',
      filteredHospitals: state.allHospitals,
    ));
  }

  Future<void> _onAssignHospitalsRequested(
    AssignHospitalsRequested event,
    Emitter<HospitalsState> emit,
  ) async {
    emit(state.copyWith(isAssigning: true, isAssignmentSuccess: false, errorMessage: null));

    final selectedIds = state.selectedIds;
    bool hasError = false;
    String? lastError;

    for (final hospitalId in selectedIds) {
      final res = await updateHospitalAssignmentUseCase(
        UpdateHospitalAssignmentParams(
          hospitalId: hospitalId,
          assignmentsId: event.assignmentsId,
          personId: event.personId,
        ),
      );

      if (res is Error) {
        hasError = true;
        lastError = res.failure.message;
      }
    }

    if (hasError) {
      emit(state.copyWith(
        isAssigning: false,
        isAssignmentSuccess: false,
        errorMessage: lastError ?? 'Error al actualizar asignaciones',
      ));
    } else {
      emit(state.copyWith(
        isAssigning: false,
        isAssignmentSuccess: true,
      ));
    }
  }

  List<Hospital> _applyFilter(List<Hospital> list, String query) {
    if (query.trim().isEmpty) return list;
    final q = query.trim().toLowerCase();

    return list.where((h) {
      final nameMatches = h.name.toLowerCase().contains(q);
      final idMatches = h.id.toString().contains(q);
      final dirMatches = h.direction.toLowerCase().contains(q);
      final barrioMatches = (h.barrio ?? '').toLowerCase().contains(q);

      return nameMatches || idMatches || dirMatches || barrioMatches;
    }).toList();
  }
}
