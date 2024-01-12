import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/logger.dart';
import 'package:echno_attendance/task_module/services/project_model.dart';
import 'package:echno_attendance/task_module/services/task_model.dart';
import 'package:echno_attendance/task_module/services/task_service.dart';
import 'package:logger/logger.dart';

class FirestoreTaskProvider implements TaskService {
  final logs = logger(FirestoreTaskProvider, Level.info);
  final CollectionReference _firestoreTasks =
      FirebaseFirestore.instance.collection('tasks');
  final CollectionReference _firestoreProjects =
      FirebaseFirestore.instance.collection('projects');

  @override
  Future<Task> addNewTask(
      {required String title,
      required String description,
      required DateTime createdAt,
      required DateTime? startDate,
      required DateTime? endDate,
      required String taskAuthor,
      required String? taskType,
      required String? taskStatus,
      required double taskProgress,
      required String? assignedEmployee,
      required String? siteOffice}) async {
    final task = await _firestoreTasks.add({
      'title': title,
      'description': description,
      'created-at': createdAt,
      'start-date': startDate,
      'end-date': endDate,
      'task-author': taskAuthor,
      'task-type': taskType,
      'task-status': taskStatus,
      'task-progress': taskProgress,
      'assigned-employee': assignedEmployee,
      'site-office': siteOffice,
    });
    logs.i('new task added..!');
    final fetchTask = await task.get();
    return Task(
      id: fetchTask.id,
      title: title,
      description: description,
      createdAt: createdAt,
      taskAuthor: taskAuthor,
      taskProgress: taskProgress,
    );
  }

  @override
  Future<void> updateTask(
      {required String taskId,
      String? newTitle,
      String? newDescription,
      DateTime? newStartDate,
      DateTime? newEndDate,
      String? newTaskType,
      String? newTaskStatus,
      double? newTaskProgress,
      String? newAssignedEmployee,
      String? newSiteOffice}) async {
    try {
      final updateData = <String, dynamic>{};

      if (newTitle != null) {
        updateData['title'] = newTitle;
      }

      if (newDescription != null) {
        updateData['description'] = newDescription;
      }

      if (newStartDate != null) {
        updateData['start-date'] = newStartDate;
      }

      if (newEndDate != null) {
        updateData['end-date'] = newEndDate;
      }

      if (newTaskType != null) {
        updateData['task-type'] = newTaskType;
      }

      if (newTaskStatus != null) {
        updateData['task-status'] = newTaskStatus;
      }

      if (newTaskProgress != null) {
        updateData['task-progress'] = newTaskProgress;
      }

      if (newAssignedEmployee != null) {
        updateData['assigned-employee'] = newAssignedEmployee;
      }

      if (newSiteOffice != null) {
        updateData['site-office'] = newSiteOffice;
      }
      await _firestoreTasks.doc(taskId).update(updateData);
      logs.i('task details updated..!');
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }
  }

  @override
  Future<void> updateTaskProgress({
    required String taskId,
    double? newTaskProgress,
    String? newTaskStatus,
  }) async {
    try {
      final updateData = <String, dynamic>{};
      if (newTaskStatus != null) {
        updateData['task-status'] = newTaskStatus;
      }

      if (newTaskProgress != null) {
        updateData['task-progress'] = newTaskProgress;
      }
      await _firestoreTasks.doc(taskId).update(updateData);
      logs.i('task status updated..!');
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }
  }

  @override
  Future<void> deleteTask({required String taskId}) async {
    try {
      await _firestoreTasks.doc(taskId).delete();
      logs.i('task deleted..!');
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }
  }

  @override
  Stream<List<Task>> streamTasksByEmployee(
      {required String? assignedEmployee}) {
    return _firestoreTasks
        .where('assigned-employee', isEqualTo: assignedEmployee)
        .snapshots()
        .map((QuerySnapshot<Object?> querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Task.fromSnapshot(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>);
      }).toList();
    });
  }

  @override
  Stream<List<Task>> streamTasksBySiteOffice({required String? siteOffice}) {
    return _firestoreTasks
        .where('site-office', isEqualTo: siteOffice)
        .snapshots()
        .map((QuerySnapshot<Object?> querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Task.fromSnapshot(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>);
      }).toList();
    });
  }

  @override
  Stream<List<Project>> streamProjectsList() {
    return _firestoreProjects
        .snapshots()
        .map((QuerySnapshot<Object?> projectSnapshot) {
      return projectSnapshot.docs.map((doc) {
        return Project.fromSnapshot(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>);
      }).toList();
    });
  }
}
