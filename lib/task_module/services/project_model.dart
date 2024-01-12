import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String projectId;
  final String description;
  final String status;
  final double longitude;
  final double latitude;
  final String? chatId;
  List<String> membersList;
  List<String> tasksList;

  Project({
    required this.projectId,
    required this.description,
    required this.status,
    required this.longitude,
    required this.latitude,
    this.chatId,
    required this.membersList,
    required this.tasksList,
  });

  Project.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> projectSnapshot)
      : projectId = projectSnapshot.data()['project-id'],
        description = projectSnapshot.data()['description'] ?? '',
        status = projectSnapshot.data()['project-status'] ?? '',
        longitude = projectSnapshot.data()['longitude'] ?? 0.0,
        latitude = projectSnapshot.data()['latitude'] ?? 0.0,
        chatId = projectSnapshot.data()['chat-id'] ?? '',
        membersList =
            List<String>.from(projectSnapshot.data()['members'] ?? []),
        tasksList = List<String>.from(projectSnapshot.data()['tasks'] ?? []);

  // Convert the Project object into a JSON-compatible map
  Map<String, dynamic> toJson() {
    return {
      'project-id': projectId,
      'description': description,
      'project-status': status,
      'longitude': longitude,
      'latitude': latitude,
      'chatId': chatId,
      'members': membersList,
      'tasks': tasksList,
    };
  }
}
