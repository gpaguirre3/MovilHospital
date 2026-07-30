import '../../../../core/network/dio_client.dart';
import '../models/activity_model.dart';

abstract class ActivityRemoteDataSource {
  Future<List<ActivityModel>> getActivities({int? recordId});
  Future<List<SubactivityModel>> getSubactivities({int? activityId});
}

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  final DioClient dioClient;

  ActivityRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<ActivityModel>> getActivities({int? recordId}) async {
    final response = await dioClient.get(
      '/activities',
      queryParameters: recordId != null ? {'recordId': recordId} : null,
    );

    if (response.data is List) {
      return (response.data as List)
          .map((item) => ActivityModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  @override
  Future<List<SubactivityModel>> getSubactivities({int? activityId}) async {
    final response = await dioClient.get(
      '/subactivities',
      queryParameters: activityId != null ? {'activityId': activityId} : null,
    );

    if (response.data is List) {
      return (response.data as List)
          .map((item) => SubactivityModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return [];
  }
}
