import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/activity_entity.dart';
import '../../domain/repositories/activity_repository.dart';
import '../datasources/activity_remote_datasource.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource remoteDataSource;

  ActivityRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<ActivityEntity>>> getActivities({int? recordId}) async {
    try {
      final activities = await remoteDataSource.getActivities(recordId: recordId);
      return Success(activities);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Error al cargar actividades: $e'));
    }
  }

  @override
  Future<Result<List<SubactivityEntity>>> getSubactivities({int? activityId}) async {
    try {
      final subactivities = await remoteDataSource.getSubactivities(activityId: activityId);
      return Success(subactivities);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Error al cargar subactividades: $e'));
    }
  }
}
