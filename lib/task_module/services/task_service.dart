import 'package:echno_attendance/task_module/services/firestore_task_provider.dart';
import 'package:echno_attendance/task_module/services/task_model.dart';
import 'package:echno_attendance/task_module/services/task_provider.dart';

class TaskService implements TaskProvider {
  final TaskProvider _taskProvider;
  const TaskService(this._taskProvider);

  factory TaskService.firestoreTasks() {
    return TaskService(FirestoreTaskProvider());
  }

  @override
  Future<Task> addNewTask({
    required String title,
    required String description,
    required DateTime createdAt,
    required DateTime? startDate,
    required DateTime? endDate,
    required String taskAuthor,
    required String? taskType,
    required String? taskStatus,
    required double taskProgress,
    required String? assignedEmployee,
    required String? siteOffice,
  }) {
    return _taskProvider.addNewTask(
      title: title,
      description: description,
      createdAt: createdAt,
      startDate: startDate,
      endDate: endDate,
      taskAuthor: taskAuthor,
      taskType: taskType,
      taskStatus: taskStatus,
      taskProgress: taskProgress,
      assignedEmployee: assignedEmployee,
      siteOffice: siteOffice,
    );
  }

  @override
  Future<void> updateTask({
    required String taskId,
    String? newTitle,
    String? newDescription,
    DateTime? newStartDate,
    DateTime? newEndDate,
    String? newTaskType,
    String? newTaskStatus,
    double? newTaskProgress,
    String? newAssignedEmployee,
    String? newSiteOffice,
  }) {
    return _taskProvider.updateTask(taskId: taskId);
  }

  @override
  Future<void> updateTaskProgress({
    required String taskId,
    double? newTaskProgress,
    String? newTaskStatus,
  }) {
    return _taskProvider.updateTaskProgress(
      taskId: taskId,
      newTaskProgress: newTaskProgress,
      newTaskStatus: newTaskStatus,
    );
  }

  @override
  Future<void> deleteTask({required String taskId}) {
    return _taskProvider.deleteTask(taskId: taskId);
  }

  @override
  Stream<List<Task>> streamTasksByEmployee(
      {required String? assignedEmployee}) {
    return _taskProvider.streamTasksByEmployee(
        assignedEmployee: assignedEmployee);
  }

  @override
  Stream<List<Task>> streamTasksBySiteOffice({required String? siteOffice}) {
    return _taskProvider.streamTasksBySiteOffice(siteOffice: siteOffice);
  }
}
