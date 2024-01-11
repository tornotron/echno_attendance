import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String projectId;
  final String name;
  final String description;
  final String status;
  final double longitude;
  final double latitude;
  final String? chatId;
  List<String> membersList;
  List<String> tasksList;

  Project({
    required this.projectId,
    required this.name,
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
        name = projectSnapshot.data()['name'],
        description = projectSnapshot.data()['description'],
        status = projectSnapshot.data()['project-status'],
        longitude = projectSnapshot.data()['longitude'],
        latitude = projectSnapshot.data()['latitude'],
        chatId = projectSnapshot.data()['chatId'] ?? '',
        membersList =
            List<String>.from(projectSnapshot.data()['members'] ?? []),
        tasksList = List<String>.from(projectSnapshot.data()['tasks'] ?? []);

  // Convert the Project object into a JSON-compatible map
  Map<String, dynamic> toJson() {
    return {
      'project-id': projectId,
      'name': name,
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
