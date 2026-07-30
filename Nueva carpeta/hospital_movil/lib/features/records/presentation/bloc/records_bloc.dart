import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/record_entity.dart';
import '../../domain/usecases/get_records_usecase.dart';
import 'records_event.dart';
import 'records_state.dart';

class RecordsBloc extends Bloc<RecordsEvent, RecordsState> {
  final GetRecordsUseCase getRecordsUseCase;

  RecordsBloc({required this.getRecordsUseCase}) : super(const RecordsState()) {
    on<FetchRecordsRequested>(_onFetchRecordsRequested);
  }

  Future<void> _onFetchRecordsRequested(
    FetchRecordsRequested event,
    Emitter<RecordsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await getRecordsUseCase(event.assignmentId);

    if (result is Success<List<RecordEntity>>) {
      emit(state.copyWith(
        isLoading: false,
        records: result.data,
      ));
    } else if (result is Error<List<RecordEntity>>) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.failure.message,
      ));
    }
  }
}
