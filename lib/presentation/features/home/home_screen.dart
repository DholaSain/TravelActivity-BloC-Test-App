import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelactivity/presentation/blocs/activity-bloc/activity_bloc.dart';
import 'package:travelactivity/presentation/widgets/activity_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover Activities"),
        actions: [
          BlocBuilder<ActivityBloc, ActivityState>(
            builder: (context, state) {
              bool isOffline = false;
              if (state is ActivityLoaded) isOffline = state.offlineMode;

              return Row(
                children: [
                  const Text("Offline"),
                  Switch(
                    value: isOffline,
                    onChanged: (val) {
                      context.read<ActivityBloc>().add(ToggleOfflineMode(val));
                    },
                  ),
                ],
              );
            },
          ),
          IconButton(
            onPressed: () {
              // context.read<ActivityBloc>().add(LoadMockData());
              // confirm if the user wants to load mock data
              showAdaptiveDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text("Load Mock Data"),
                    content: const Text(
                      "Are you sure you want to load mock data?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<ActivityBloc>().add(
                            const LoadMockData(false),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text("Load"),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<ActivityBloc>().add(
                            const LoadMockData(true),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text("Load & Overwrite"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.download),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<ActivityBloc, ActivityState>(
        builder: (context, state) {
          if (state is ActivityLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ActivityLoaded) {
            if (state.activities.isEmpty) {
              return const Center(child: Text("No activities found."));
            }

            return Column(
              children: [
                if (state.offlineMode)
                  Container(
                    color: Colors.amber.shade100,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      "You are in Offline Mode",
                      textAlign: TextAlign.center,
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: state.activities.length,
                    itemBuilder: (context, index) {
                      return ActivityCard(activity: state.activities[index]);
                    },
                  ),
                ),
              ],
            );
          } else if (state is ActivityError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text("Welcome!"));
        },
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 👈 Important!
      builder: (context) {
        String? selectedType;
        String? selectedDate;
        int? selectedGroupSize;

        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom:
                MediaQuery.of(context).viewInsets.bottom +
                16, // 👈 Keyboard-aware padding
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Filter Activities",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Date (YYYY-MM-DD)",
                  ),
                  onChanged: (val) => selectedDate = val,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Activity Type (e.g., Hiking)",
                  ),
                  onChanged: (val) => selectedType = val,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: "Group Size"),
                  keyboardType: TextInputType.number,
                  onChanged: (val) => selectedGroupSize = int.tryParse(val),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<ActivityBloc>().add(
                      ApplyFilters(
                        date: selectedDate,
                        type: selectedType,
                        groupSize: selectedGroupSize,
                      ),
                    );
                  },
                  child: const Text("Apply Filters"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
