import '../../../../core/usecase/usecase.dart';
import '../entities/assignment.dart';
import '../repositories/assignment_repository.dart';

class GetAssignmentsUseCase implements UseCase<List<Assignment>, NoParams> {
  final AssignmentRepository repository;

  GetAssignmentsUseCase(this.repository);

  @override
  Future<Result<List<Assignment>>> call(NoParams params) async {
    return await repository.getAssignments();
  }
}
