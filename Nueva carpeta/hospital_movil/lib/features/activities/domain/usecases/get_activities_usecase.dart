import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/activity_entity.dart';
import '../repositories/activity_repository.dart';

class GetActivitiesParams extends Equatable {
  final int? recordId;

  const GetActivitiesParams({this.recordId});

  @override
  List<Object?> get props => [recordId];
}

class GetSubactivitiesParams extends Equatable {
  final int? activityId;

  const GetSubactivitiesParams({this.activityId});

  @override
  List<Object?> get props => [activityId];
}

class GetActivitiesUseCase implements UseCase<List<ActivityEntity>, GetActivitiesParams> {
  final ActivityRepository repository;

  GetActivitiesUseCase(this.repository);

  @override
  Future<Result<List<ActivityEntity>>> call(GetActivitiesParams params) async {
    return await repository.getActivities(recordId: params.recordId);
  }
}

class GetSubactivitiesUseCase implements UseCase<List<SubactivityEntity>, GetSubactivitiesParams> {
  final ActivityRepository repository;

  GetSubactivitiesUseCase(this.repository);

  @override
  Future<Result<List<SubactivityEntity>>> call(GetSubactivitiesParams params) async {
    return await repository.getSubactivities(activityId: params.activityId);
  }
}
