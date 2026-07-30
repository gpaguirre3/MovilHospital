import 'package:equatable/equatable.dart';
import '../../domain/entities/hospital.dart';

class HospitalsState extends Equatable {
  final bool isLoading;
  final bool isAssigning;
  final bool isAssignmentSuccess;
  final List<Hospital> allHospitals;
  final List<Hospital> filteredHospitals;
  final Set<int> selectedIds;
  final String searchQuery;
  final String? errorMessage;

  const HospitalsState({
    this.isLoading = false,
    this.isAssigning = false,
    this.isAssignmentSuccess = false,
    this.allHospitals = const [],
    this.filteredHospitals = const [],
    this.selectedIds = const {},
    this.searchQuery = '',
    this.errorMessage,
  });

  bool get isAllSelected =>
      filteredHospitals.isNotEmpty &&
      filteredHospitals.every((h) => selectedIds.contains(h.id));

  int get selectedCount => selectedIds.length;
  int get totalCount => allHospitals.length;

  List<Hospital> get selectedHospitals =>
      allHospitals.where((h) => selectedIds.contains(h.id)).toList();

  HospitalsState copyWith({
    bool? isLoading,
    bool? isAssigning,
    bool? isAssignmentSuccess,
    List<Hospital>? allHospitals,
    List<Hospital>? filteredHospitals,
    Set<int>? selectedIds,
    String? searchQuery,
    String? errorMessage,
  }) {
    return HospitalsState(
      isLoading: isLoading ?? this.isLoading,
      isAssigning: isAssigning ?? this.isAssigning,
      isAssignmentSuccess: isAssignmentSuccess ?? this.isAssignmentSuccess,
      allHospitals: allHospitals ?? this.allHospitals,
      filteredHospitals: filteredHospitals ?? this.filteredHospitals,
      selectedIds: selectedIds ?? this.selectedIds,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isAssigning,
        isAssignmentSuccess,
        allHospitals,
        filteredHospitals,
        selectedIds,
        searchQuery,
        errorMessage,
      ];
}
