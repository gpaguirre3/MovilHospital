import '../../../../core/usecase/usecase.dart';
import '../entities/hospital.dart';
import '../repositories/hospital_repository.dart';

class GetHospitalsUseCase implements UseCase<List<Hospital>, NoParams> {
  final HospitalRepository repository;

  GetHospitalsUseCase(this.repository);

  @override
  Future<Result<List<Hospital>>> call(NoParams params) async {
    return await repository.getHospitals();
  }
}
