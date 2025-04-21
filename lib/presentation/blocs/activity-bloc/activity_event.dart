part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object?> get props => [];
}

class LoadActivities extends ActivityEvent {
  final bool offlineMode;

  const LoadActivities({this.offlineMode = false});

  @override
  List<Object?> get props => [offlineMode];
}

class ApplyFilters extends ActivityEvent {
  final String? date;
  final String? type;
  final int? groupSize;

  const ApplyFilters({this.date, this.type, this.groupSize});

  @override
  List<Object?> get props => [date, type, groupSize];
}

class ToggleSaveActivity extends ActivityEvent {
  final int activityId;
  final bool isSaved;

  const ToggleSaveActivity(this.activityId, this.isSaved);

  @override
  List<Object?> get props => [activityId, isSaved];
}

class ToggleJoinActivity extends ActivityEvent {
  final int activityId;
  final bool isJoined;

  const ToggleJoinActivity(this.activityId, this.isJoined);

  @override
  List<Object?> get props => [activityId, isJoined];
}

class ToggleOfflineMode extends ActivityEvent {
  final bool offline;

  const ToggleOfflineMode(this.offline);

  @override
  List<Object?> get props => [offline];
}

class LoadMockData extends ActivityEvent {
  final bool overwrite;
  const LoadMockData(this.overwrite);

  @override
  List<Object?> get props => [overwrite];
}
