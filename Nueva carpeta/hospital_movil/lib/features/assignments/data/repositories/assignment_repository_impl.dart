import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/assignment.dart';
import '../../domain/repositories/assignment_repository.dart';
import '../datasources/assignment_remote_datasource.dart';

class AssignmentRepositoryImpl implements AssignmentRepository {
  final AssignmentRemoteDataSource remoteDataSource;

  AssignmentRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<Assignment>>> getAssignments() async {
    try {
      final assignments = await remoteDataSource.getAssignments();
      return Success(assignments);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Error al cargar las asignaciones: $e'));
    }
  }
}
