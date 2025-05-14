import '../models/task.dart';

class TaskRepository {
  final List<Task> _tasks = [];

  Future<List<Task>> getAllTasks() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simula operação assíncrona
    return _tasks.toList();
  }

  Future<void> addTask(Task task) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _tasks.add(task);
  }

  Future<void> updateTask(Task updatedTask) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
    }
  }

  Future<void> deleteTask(String taskId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _tasks.removeWhere((task) => task.id == taskId);
  }
}