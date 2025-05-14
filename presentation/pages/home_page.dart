import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/constants.dart';
import 'package:todo_list/presentation/widgets/custom_fab.dart';
import 'package:todo_list/presentation/widgets/empty_state.dart';
import 'package:todo_list/presentation/widgets/task_card.dart';
import '../providers/task_provider.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.tasks.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.tasks.isEmpty) {
            return EmptyState(
              title: AppConstants.emptyStateTitle,
              subtitle: AppConstants.emptyStateSubtitle,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.tasks.length,
            itemBuilder: (context, index) {
              final task = provider.tasks[index];
              return TaskCard(
                task: task,
                onToggleCompletion: () => provider.toggleTaskCompletion(task),
                onDelete: () => provider.deleteTask(task.id),
              );
            },
          );
        },
      ),
      floatingActionButton: CustomFAB(
        onPressed: () => _navigateToAddTask(context),
      ),
    );
  }

  void _navigateToAddTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskPage()),
    );
  }
}