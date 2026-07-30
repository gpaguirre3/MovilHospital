import '../../../../core/usecase/usecase.dart';
import '../entities/hospital.dart';

abstract class HospitalRepository {
  Future<Result<List<Hospital>>> getHospitals();

  Future<Result<void>> updateHospitalAssignment({
    required int hospitalId,
    required int assignmentsId,
    int? personId,
  });
}
