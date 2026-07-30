import '../../../../core/usecase/usecase.dart';
import '../entities/assignment.dart';

abstract class AssignmentRepository {
  Future<Result<List<Assignment>>> getAssignments();
}
