import 'package:echno_attendance/task_module/services/task_model.dart';

abstract class TaskProvider {
  Future<void> addNewTask({
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
  });

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
  });

  Future<void> updateTaskProgress({
    required String taskId,
    double? newTaskProgress,
    String? newTaskStatus,
  });

  Future<void> deleteTask({
    required String taskId,
  });

  Stream<List<Task>> streamTasksByEmployee({
    required String? assignedEmployee,
  });

  Stream<List<Task>> streamTasksBySiteOffice({
    required String? siteOffice,
  });
}
