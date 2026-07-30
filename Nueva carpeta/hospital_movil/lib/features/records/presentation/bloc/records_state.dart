import 'package:equatable/equatable.dart';
import '../../domain/entities/record_entity.dart';

class RecordsState extends Equatable {
  final bool isLoading;
  final List<RecordEntity> records;
  final String? errorMessage;

  const RecordsState({
    this.isLoading = false,
    this.records = const [],
    this.errorMessage,
  });

  RecordsState copyWith({
    bool? isLoading,
    List<RecordEntity>? records,
    String? errorMessage,
  }) {
    return RecordsState(
      isLoading: isLoading ?? this.isLoading,
      records: records ?? this.records,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, records, errorMessage];
}
