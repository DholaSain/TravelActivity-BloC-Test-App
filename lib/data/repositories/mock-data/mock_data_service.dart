import 'package:travelactivity/core/mock/mock_activities.dart';
import 'package:travelactivity/data/repositories/activity/activity_repo.dart';

class MockDataService {
  final ActivityRepository repository;

  MockDataService(this.repository);

  // Clears old data and inserts fresh mock data
  Future<void> populateMockData() async {
    await repository.clearAllActivities();
    await repository.insertMockActivities(mockActivities);
  }

  // Insert only if DB is empty
  Future<void> populateIfEmpty() async {
    final existing = await repository.getAllActivities();
    if (existing.isEmpty) {
      await populateMockData();
    }
  }
}
