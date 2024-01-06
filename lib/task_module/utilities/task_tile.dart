import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/task_module/services/task_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {
  final Task? task;

  const TaskTile(this.task, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double taskProgress = task!.taskProgress / 100;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: _getBGClr(task?.status, task?.taskType),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task?.title ?? "",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        "${_formatDate(task?.startDate)} - ${_formatDate(task?.endDate)}",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 13.0, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_2_rounded,
                        color: Colors.grey[200],
                        size: 18.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        "${task?.assignedEmployee} ",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 13.0, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: taskProgress,
                          color: Colors.grey[200],
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.grey[100]!),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        "${(task?.taskProgress)}% ",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 13.0, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    task?.description ?? "",
                    maxLines: 1,
                    style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 15.0, color: Colors.grey[100]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              height: 60.0,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task?.taskType == TaskType.open
                    ? _getStatusString(task?.status)
                    : _getTypeString(task?.taskType),
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getBGClr(TaskStatus? status, TaskType? type) {
    if (type == TaskType.closed) {
      return closedTaskColor;
    }
    switch (status) {
      case TaskStatus.todo:
        return upcomingTaskColor;
      case TaskStatus.inProgress:
        return ongoingTaskColor;
      case TaskStatus.onhold:
        return onholdTaskColor;
      case TaskStatus.completed:
        return completedTaskColor;

      default:
        return upcomingTaskColor;
    }
  }

  String _getStatusString(TaskStatus? status) {
    switch (status) {
      case TaskStatus.todo:
        return 'TODO';
      case TaskStatus.inProgress:
        return 'IN PROGRESS';
      case TaskStatus.onhold:
        return 'ON HOLD';
      case TaskStatus.completed:
        return 'COMPLETED';
      default:
        return 'TODO';
    }
  }

  String _getTypeString(TaskType? taskType) {
    switch (taskType) {
      case TaskType.open:
        return 'OPEN';
      case TaskType.closed:
        return 'DISPOSED';
      default:
        return 'CLOSED';
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return ""; // Handle null date case
    }
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }
}
