import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:developer' as devtools show log;

// Represent the type of task
enum TaskType {
  open,
  closed,
}

// Represent the status of the task
enum TaskStatus {
  todo,
  inProgress,
  onhold,
  completed,
}

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? startDate;
  final DateTime? endDate;
  final String taskAuthor;
  final TaskType? taskType;
  final double taskProgress;
  final String? assignedEmployee;
  final String? siteOffice;
  final TaskStatus? status;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.startDate,
    this.endDate,
    required this.taskAuthor,
    this.taskType,
    required this.taskProgress,
    this.assignedEmployee,
    this.siteOffice,
    this.status,
  });

  Task.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        title = snapshot.data()['title'],
        description = snapshot.data()['description'],
        createdAt = snapshot.data()['created-at'],
        startDate = snapshot.data()['start-date'],
        endDate = snapshot.data()['start-date'],
        taskAuthor = snapshot.data()['task-author'],
        taskType = snapshot.data()['task-type'],
        status = snapshot.data()['task-status'],
        taskProgress = snapshot.data()['task-progress'],
        assignedEmployee = snapshot.data()['assigned-employee'],
        siteOffice = snapshot.data()['site-office'];

  // factory Task.fromDocument(QueryDocumentSnapshot doc) {
  //   try {
  //     final data = doc.data() as Map<String, dynamic>;
  //     return Task(
  //       id: doc.id,
  //       title: data['title'] ?? '',
  //       description: data['description'] ?? '',
  //       createdAt: (data['created-at'] as Timestamp).toDate(),
  //       startDate: _parseTimestamp(data['start-date']),
  //       endDate: _parseTimestamp(data['end-date']),
  //       taskAuthor: data['task-author'] ?? '',
  //       taskType: _parseTaskType(data['task-type']),
  //       status: _parseTaskStatus(data['task-status']),
  //       taskProgress: (data['task-progress'] ?? 0.0).toDouble(),
  //       assignedEmployee: data['assigned-employee'] ?? '',
  //       siteOffice: data['site-office'] ?? '',
  //     );
  //   } catch (e) {
  //     // Handle errors, log, or throw a more specific exception.
  //     devtools.log('Error getting Task from document: $e');
  //     // Throw an exception here or return a default Task.
  //     return Task(
  //       id: doc.id,
  //       title: 'Error',
  //       description: 'Error',
  //       createdAt: DateTime.now(),
  //       taskAuthor: 'Error',
  //       taskProgress: 0.0,
  //     );
  //   }
  // }

  // // Method to parse a timestamp from Firestore into a DateTime object
  // static DateTime? _parseTimestamp(dynamic timestamp) {
  //   if (timestamp is Timestamp) {
  //     return timestamp.toDate();
  //   }
  //   return null;
  // }

  // // Method to parse task type from a string
  // static TaskType? _parseTaskType(String? type) {
  //   if (type == 'OPEN') {
  //     return TaskType.open;
  //   } else if (type == 'CLOSED') {
  //     return TaskType.closed;
  //   }
  //   return null;
  // }

  // // Method to parse task status from a string
  // static TaskStatus? _parseTaskStatus(String? status) {
  //   if (status == 'TODO') {
  //     return TaskStatus.todo;
  //   } else if (status == 'IN_PROGRESS') {
  //     return TaskStatus.inProgress;
  //   } else if (status == 'ON_HOLD') {
  //     return TaskStatus.onhold;
  //   } else if (status == 'COMPLETED') {
  //     return TaskStatus.completed;
  //   }
  //   return null;
  // }

  //Specifying the properties used for equality comparison
  @override
  List<Object?> get props => [
        createdAt,
        taskAuthor,
        taskType,
        assignedEmployee,
        siteOffice,
        status,
      ];

  // // Convert the Task object into a JSON-compatible map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created-at': createdAt,
      'start-date': startDate,
      'end-date': endDate,
      'task-author': taskAuthor,
      'task-type': taskType?.toString().split('.').last,
      'task-status': status?.toString().split('.').last,
      'task-progress': taskProgress,
      'assigned-employee': assignedEmployee,
      'site-office': siteOffice,
    };
  }
}
