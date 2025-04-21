class UserAction {
  final int? id;
  final int activityId;
  final bool isSaved;
  final bool isJoined;

  UserAction({
    this.id,
    required this.activityId,
    this.isSaved = false,
    this.isJoined = false,
  });

  factory UserAction.fromMap(Map<String, dynamic> map) {
    return UserAction(
      id: map['id'],
      activityId: map['activity_id'],
      isSaved: map['is_saved'] == 1,
      isJoined: map['is_joined'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'activity_id': activityId,
      'is_saved': isSaved ? 1 : 0,
      'is_joined': isJoined ? 1 : 0,
    };
  }
}
