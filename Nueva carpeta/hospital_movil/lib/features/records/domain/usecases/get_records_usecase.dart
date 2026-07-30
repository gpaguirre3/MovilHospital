import '../../../../core/usecase/usecase.dart';
import '../entities/record_entity.dart';
import '../repositories/record_repository.dart';

class GetRecordsUseCase implements UseCase<List<RecordEntity>, int?> {
  final RecordRepository repository;

  GetRecordsUseCase(this.repository);

  @override
  Future<Result<List<RecordEntity>>> call(int? assignmentId) async {
    return await repository.getRecords(assignmentId: assignmentId);
  }
}
