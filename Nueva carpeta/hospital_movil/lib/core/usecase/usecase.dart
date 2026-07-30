import 'package:equatable/equatable.dart';
import '../error/failures.dart';

abstract class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);
}

abstract class UseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
