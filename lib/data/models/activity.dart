class Activity {
  final int? id;
  final String title;
  final String description;
  final String location;
  final String date;
  final String? startTime;
  final String? endTime;
  final String type;
  final int? groupSize;
  final int? capacity;
  final int popularityScore;
  final bool isEndingSoon;
  final bool isSaved;
  final bool isJoined;

  Activity({
    this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    this.startTime,
    this.endTime,
    required this.type,
    this.groupSize,
    this.capacity,
    required this.popularityScore,
    this.isEndingSoon = false,
    this.isSaved = false,
    this.isJoined = false,
  });

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      location: map['location'],
      date: map['date'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      type: map['type'],
      groupSize: map['group_size'],
      capacity: map['capacity'],
      popularityScore: map['popularity_score'] ?? 0,
      isEndingSoon: map['is_ending_soon'] == 1,
      isSaved: map['is_saved'] == 1,
      isJoined: map['is_joined'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'type': type,
      'group_size': groupSize,
      'capacity': capacity,
      'popularity_score': popularityScore,
      'is_ending_soon': isEndingSoon ? 1 : 0,
      'is_saved': isSaved ? 1 : 0,
      'is_joined': isJoined ? 1 : 0,
    };
  }
}
