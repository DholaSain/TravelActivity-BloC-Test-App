import 'package:sqflite/sqflite.dart';
import 'package:travelactivity/core/database/database.dart';
import 'package:travelactivity/data/models/activity.dart';
import 'package:travelactivity/data/repositories/network_client/request_client.dart';

class ActivityRepository {
  final DatabaseHelper dbHelper;
  final RequestClient requestClient;

  ActivityRepository({required this.dbHelper, required this.requestClient});

  Future<int> insertActivity(Activity activity) async {
    final db = await dbHelper.database;
    return await db.insert(
      'activities',
      activity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Activity>> getAllActivities() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('activities');
    return maps.map((map) => Activity.fromMap(map)).toList();
  }

  Future<List<Activity>> getAllActivitiesFromRemoteClient() async {
    // This method is a placeholder for fetching activities from a remote client
    // You can implement the actual network call using requestClient here
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('activities');
    return maps.map((map) => Activity.fromMap(map)).toList();
  }

  Future<Activity?> getActivityById(int id) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'activities',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Activity.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateActivity(Activity activity) async {
    final db = await dbHelper.database;
    return await db.update(
      'activities',
      activity.toMap(),
      where: 'id = ?',
      whereArgs: [activity.id],
    );
  }

  Future<int> deleteActivity(int id) async {
    final db = await dbHelper.database;
    return await db.delete('activities', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Activity>> filterActivities({
    String? date,
    String? type,
    int? groupSize,
  }) async {
    final db = await dbHelper.database;
    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (date != null) {
      whereClause += 'date = ?';
      whereArgs.add(date);
    }

    if (type != null) {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      whereClause += 'type = ?';
      whereArgs.add(type);
    }

    if (groupSize != null) {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      whereClause += 'group_size <= ?';
      whereArgs.add(groupSize);
    }

    final List<Map<String, dynamic>> result = await db.query(
      'activities',
      where: whereClause.isNotEmpty ? whereClause : null,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );

    return result.map((map) => Activity.fromMap(map)).toList();
  }

  Future<List<Activity>> getSavedActivities() async {
    final db = await dbHelper.database;
    final result = await db.query('activities', where: 'is_saved = 1');
    return result.map((map) => Activity.fromMap(map)).toList();
  }

  Future<List<Activity>> getJoinedActivities() async {
    final db = await dbHelper.database;
    final result = await db.query('activities', where: 'is_joined = 1');
    return result.map((map) => Activity.fromMap(map)).toList();
  }

  // 🔹 Mark as saved
  Future<void> toggleSave(int id, bool isSaved) async {
    final db = await dbHelper.database;
    await db.update(
      'activities',
      {'is_saved': isSaved ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 🔹 Mark as joined
  Future<void> toggleJoin(int id, bool isJoined) async {
    final db = await dbHelper.database;
    await db.update(
      'activities',
      {'is_joined': isJoined ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 🔹 Clear all activities (for mock sync or reset)
  Future<void> clearAllActivities() async {
    final db = await dbHelper.database;
    await db.delete('activities');
  }

  // 🔹 Insert multiple mock activities
  Future<void> insertMockActivities(List<Activity> activities) async {
    for (final activity in activities) {
      await insertActivity(activity);
    }
  }
}
