import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelactivity/data/models/activity.dart';
import 'package:travelactivity/presentation/blocs/activity-bloc/activity_bloc.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    activity.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(activity.date),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              activity.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(activity.type),
            const SizedBox(height: 8),
            Text(
              "${activity.startTime} - ${activity.endTime}",
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.place, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(activity.location),
                const Spacer(),
                if (activity.isEndingSoon)
                  const Chip(
                    label: Text(
                      "Ending Soon",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                if (activity.popularityScore > 80)
                  const Chip(
                    label: Text(
                      "Popular",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.people, size: 16),
                const SizedBox(width: 4),
                Text("Group: ${activity.groupSize}/${activity.capacity}"),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    activity.isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: activity.isSaved ? Colors.blue : null,
                  ),
                  onPressed: () {
                    context.read<ActivityBloc>().add(
                      ToggleSaveActivity(activity.id!, !activity.isSaved),
                    );
                  },
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<ActivityBloc>().add(
                      ToggleJoinActivity(activity.id!, !activity.isJoined),
                    );
                  },
                  icon: Icon(activity.isJoined ? Icons.check : Icons.add),
                  label: Text(activity.isJoined ? "Joined" : "Join"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        activity.isJoined ? Colors.grey : Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
