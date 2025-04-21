import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelactivity/data/models/activity.dart';
import 'package:travelactivity/data/repositories/activity/activity_repo.dart';
import 'package:travelactivity/data/repositories/mock-data/mock_data_service.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityRepository repository;
  final MockDataService mockDataService;

  ActivityBloc({required this.repository, required this.mockDataService})
    : super(ActivityInitial()) {
    on<LoadActivities>(_onLoadActivities);
    on<ApplyFilters>(_onApplyFilters);
    on<ToggleSaveActivity>(_onToggleSaveActivity);
    on<ToggleJoinActivity>(_onToggleJoinActivity);
    on<ToggleOfflineMode>(_onToggleOfflineMode);
    on<LoadMockData>(_onLoadMockData);
  }

  Future<void> _onLoadActivities(
    LoadActivities event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());
    try {
      final activities = await repository.getAllActivities();
      emit(ActivityLoaded(activities, offlineMode: event.offlineMode));
    } catch (e) {
      emit(ActivityError("Failed to load activities."));
    }
  }

  Future<void> _onApplyFilters(
    ApplyFilters event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());
    try {
      final filtered = await repository.filterActivities(
        date: event.date,
        type: event.type,
        groupSize: event.groupSize,
      );
      emit(ActivityLoaded(filtered));
    } catch (e) {
      emit(ActivityError("Filtering failed."));
    }
  }

  Future<void> _onToggleSaveActivity(
    ToggleSaveActivity event,
    Emitter<ActivityState> emit,
  ) async {
    await repository.toggleSave(event.activityId, event.isSaved);
    add(const LoadActivities());
  }

  Future<void> _onToggleJoinActivity(
    ToggleJoinActivity event,
    Emitter<ActivityState> emit,
  ) async {
    await repository.toggleJoin(event.activityId, event.isJoined);
    add(const LoadActivities());
  }

  Future<void> _onToggleOfflineMode(
    ToggleOfflineMode event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());

    try {
      final activities =
          event.offline
              ? await repository.getAllActivities()
              : await repository.getAllActivitiesFromRemoteClient();

      emit(ActivityLoaded(activities, offlineMode: event.offline));
    } catch (e) {
      emit(ActivityError("Failed to toggle offline mode."));
    }
  }

  Future<void> _onLoadMockData(
    LoadMockData event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());
    try {
      if (event.overwrite) {
        await mockDataService.populateMockData();
      } else {
        await mockDataService.populateIfEmpty();
      }
      add(const LoadActivities());
    } catch (e) {
      emit(ActivityError("Failed to load mock data."));
    }
  }
}
