import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/activity_entity.dart';
import '../../domain/usecases/get_activities_usecase.dart';
import 'activities_event.dart';
import 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final GetActivitiesUseCase getActivitiesUseCase;
  final GetSubactivitiesUseCase getSubactivitiesUseCase;

  ActivitiesBloc({
    required this.getActivitiesUseCase,
    required this.getSubactivitiesUseCase,
  }) : super(const ActivitiesState()) {
    on<FetchActivitiesRequested>(_onFetchActivitiesRequested);
  }

  Future<void> _onFetchActivitiesRequested(
    FetchActivitiesRequested event,
    Emitter<ActivitiesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final actResult = await getActivitiesUseCase(const GetActivitiesParams());
    final subResult = await getSubactivitiesUseCase(const GetSubactivitiesParams());

    List<ActivityEntity> activities = [];
    List<SubactivityEntity> subactivities = [];
    String? error;

    if (actResult is Success<List<ActivityEntity>>) {
      activities = actResult.data;
    } else if (actResult is Error<List<ActivityEntity>>) {
      error = actResult.failure.message;
    }

    if (subResult is Success<List<SubactivityEntity>>) {
      subactivities = subResult.data;
    } else if (subResult is Error<List<SubactivityEntity>>) {
      error ??= subResult.failure.message;
    }

    emit(state.copyWith(
      isLoading: false,
      activities: activities,
      subactivities: subactivities,
      errorMessage: error,
    ));
  }
}
