import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/hospital.dart';
import '../../domain/repositories/hospital_repository.dart';
import '../datasources/hospital_remote_datasource.dart';

class HospitalRepositoryImpl implements HospitalRepository {
  final HospitalRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HospitalRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result<List<Hospital>>> getHospitals() async {
    try {
      final hospitals = await remoteDataSource.getHospitals();
      return Success(hospitals);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Error al cargar la lista de hospitales: $e'));
    }
  }

  @override
  Future<Result<void>> updateHospitalAssignment({
    required int hospitalId,
    required int assignmentsId,
    int? personId,
  }) async {
    try {
      await remoteDataSource.updateHospitalAssignment(
        hospitalId: hospitalId,
        assignmentsId: assignmentsId,
        personId: personId,
      );
      return const Success(null);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Error al asignar hospital: $e'));
    }
  }
}
