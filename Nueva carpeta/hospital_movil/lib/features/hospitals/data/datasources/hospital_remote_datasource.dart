import '../../../../core/network/dio_client.dart';
import '../models/hospital_model.dart';

abstract class HospitalRemoteDataSource {
  Future<List<HospitalModel>> getHospitals();

  Future<void> updateHospitalAssignment({
    required int hospitalId,
    required int assignmentsId,
    int? personId,
  });
}

class HospitalRemoteDataSourceImpl implements HospitalRemoteDataSource {
  final DioClient dioClient;

  HospitalRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<HospitalModel>> getHospitals() async {
    final response = await dioClient.get('/hospitals');

    if (response.data is List) {
      return (response.data as List)
          .map((item) => HospitalModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  @override
  Future<void> updateHospitalAssignment({
    required int hospitalId,
    required int assignmentsId,
    int? personId,
  }) async {
    // 1. Fetch current hospital details to preserve name, direction, lat, long
    HospitalModel? existing;
    try {
      final res = await dioClient.get('/hospitals/$hospitalId');
      if (res.data != null) {
        existing = HospitalModel.fromJson(res.data);
      }
    } catch (_) {}

    // 2. Perform PUT request with updated assignmentsId and personId as requested
    await dioClient.post(
      '/hospitals', // Spring Boot save endpoint handles create/update or put endpoint
      data: {
        'hospitalId': hospitalId,
        'assignmentsId': assignmentsId,
        'personId': personId,
        'hospitalName': existing?.name ?? 'HOSPITAL ASOCIADO',
        'hospitalDirection': existing != null
            ? (existing.barrio != null ? '${existing.direction}, ${existing.barrio}' : existing.direction)
            : 'Av. Principal',
        'hospitalLatitude': existing?.latitude ?? '0.0',
        'hospitalLongitude': existing?.longitude ?? '0.0',
      },
    );
  }
}
