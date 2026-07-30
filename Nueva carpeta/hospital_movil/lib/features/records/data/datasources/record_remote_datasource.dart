import '../../../../core/network/dio_client.dart';
import '../models/record_model.dart';

abstract class RecordRemoteDataSource {
  Future<List<RecordModel>> getRecords({int? assignmentId});
}

class RecordRemoteDataSourceImpl implements RecordRemoteDataSource {
  final DioClient dioClient;

  RecordRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<RecordModel>> getRecords({int? assignmentId}) async {
    final queryParams = assignmentId != null ? {'assignmentId': assignmentId} : null;
    final response = await dioClient.get('/records', queryParameters: queryParams);

    if (response.data is List) {
      return (response.data as List)
          .map((item) => RecordModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return [];
  }
}
