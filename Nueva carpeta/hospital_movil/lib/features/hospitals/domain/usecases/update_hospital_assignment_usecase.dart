import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/hospital_repository.dart';

class UpdateHospitalAssignmentParams extends Equatable {
  final int hospitalId;
  final int assignmentsId;
  final int? personId;

  const UpdateHospitalAssignmentParams({
    required this.hospitalId,
    required this.assignmentsId,
    this.personId,
  });

  @override
  List<Object?> get props => [hospitalId, assignmentsId, personId];
}

class UpdateHospitalAssignmentUseCase implements UseCase<void, UpdateHospitalAssignmentParams> {
  final HospitalRepository repository;

  UpdateHospitalAssignmentUseCase(this.repository);

  @override
  Future<Result<void>> call(UpdateHospitalAssignmentParams params) async {
    return await repository.updateHospitalAssignment(
      hospitalId: params.hospitalId,
      assignmentsId: params.assignmentsId,
      personId: params.personId,
    );
  }
}
