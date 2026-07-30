import '../../../../core/usecase/usecase.dart';
import '../entities/record_entity.dart';

abstract class RecordRepository {
  Future<Result<List<RecordEntity>>> getRecords({int? assignmentId});
}
