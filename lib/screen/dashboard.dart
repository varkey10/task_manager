import 'package:flutter/material.dart';
import 'package:task_manager/screen/add_task.dart';
import 'package:task_manager/screen/settings.dart';
import 'package:task_manager/widgets/dashboard.dart';

class TasksDashboard extends StatelessWidget {
  const TasksDashboard({super.key});

  Widget _buildFilters() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FilterButton(label: 'All'),
        FilterButton(label: 'Pending'),
        FilterButton(label: 'Completed'),
      ],
    );
  }

  Widget _buildMetrics() {
    return const Row(
      children: [
        MetricCard(title: 'Bug Count', value: '12'),
        MetricCard(title: 'Sprint Progress', value: '75%'),
      ],
    );
  }

  Widget _buildTeamWorkload() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Team Workload', style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 8),
          const Text(
            '60%',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskLists() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 16),
        Text('Pending',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TaskItem(title: 'Grocery Shopping', subtitle: 'Due: Today'),
        TaskItem(title: 'Project Presentation', subtitle: 'Due: Tomorrow'),
        SizedBox(height: 16),
        Text('Completed',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TaskItem(
          title: 'Book Appointment',
          subtitle: 'Completed: Yesterday',
          isCompleted: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('Tasks'),
        actions: [
          Tooltip(
            message: "Add Task",
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const NewTaskSheet(),
                    );
                  }, // ← your custom widget
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Tasks'),
          BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(),
                      ));
                },
                icon: Icon(Icons.settings)),
            label: 'Profile',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search tasks',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildFilters(),
            const SizedBox(height: 16),
            _buildMetrics(),
            _buildTeamWorkload(),
            _buildTaskLists(),
          ],
        ),
      ),
    );
  }
}
