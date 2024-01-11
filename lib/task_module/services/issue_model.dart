import 'package:cloud_firestore/cloud_firestore.dart';

class Issue {
  final String issueId;
  final String taskId;
  final String title;
  final String description;
  final String status;

  Issue({
    required this.issueId,
    required this.taskId,
    required this.title,
    required this.description,
    required this.status,
  });

  Issue.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> issueSnapshot)
      : issueId = issueSnapshot.id,
        taskId = issueSnapshot.data()['task-id'],
        title = issueSnapshot.data()['title'],
        description = issueSnapshot.data()['description'],
        status = issueSnapshot.data()['issue-status'];

  // Convert the Issue object into a JSON-compatible map
  Map<String, dynamic> toJson() {
    return {
      'issue-id': issueId,
      'task-id': taskId,
      'title': title,
      'description': description,
      'issue-status': status,
    };
  }
}
