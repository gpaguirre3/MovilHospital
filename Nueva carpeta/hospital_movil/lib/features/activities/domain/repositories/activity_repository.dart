import '../../../../core/usecase/usecase.dart';
import '../entities/activity_entity.dart';

abstract class ActivityRepository {
  Future<Result<List<ActivityEntity>>> getActivities({int? recordId});
  Future<Result<List<SubactivityEntity>>> getSubactivities({int? activityId});
}
