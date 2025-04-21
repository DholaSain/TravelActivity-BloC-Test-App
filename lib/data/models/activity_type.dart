class ActivityType {
  final int? id;
  final String name;

  ActivityType({this.id, required this.name});

  factory ActivityType.fromMap(Map<String, dynamic> map) {
    return ActivityType(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
