import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/record_entity.dart';
import '../../domain/repositories/record_repository.dart';
import '../datasources/record_remote_datasource.dart';

class RecordRepositoryImpl implements RecordRepository {
  final RecordRemoteDataSource remoteDataSource;

  RecordRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<RecordEntity>>> getRecords({int? assignmentId}) async {
    try {
      final records = await remoteDataSource.getRecords(assignmentId: assignmentId);
      return Success(records);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Error al obtener registros: $e'));
    }
  }
}
