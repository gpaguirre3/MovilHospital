import 'package:equatable/equatable.dart';
import '../../domain/entities/activity_entity.dart';

class ActivitiesState extends Equatable {
  final bool isLoading;
  final List<ActivityEntity> activities;
  final List<SubactivityEntity> subactivities;
  final String? errorMessage;

  const ActivitiesState({
    this.isLoading = false,
    this.activities = const [],
    this.subactivities = const [],
    this.errorMessage,
  });

  ActivitiesState copyWith({
    bool? isLoading,
    List<ActivityEntity>? activities,
    List<SubactivityEntity>? subactivities,
    String? errorMessage,
  }) {
    return ActivitiesState(
      isLoading: isLoading ?? this.isLoading,
      activities: activities ?? this.activities,
      subactivities: subactivities ?? this.subactivities,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, activities, subactivities, errorMessage];
}
