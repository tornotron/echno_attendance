import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/task_module/services/task_model.dart';

getTaskTileBGClr(TaskStatus? status, TaskType? type) {
  if (type == TaskType.closed) {
    return closedTaskColor;
  }
  switch (status) {
    case TaskStatus.todo:
      return upcomingTaskColor;
    case TaskStatus.inProgress:
      return ongoingTaskColor;
    case TaskStatus.onHold:
      return onholdTaskColor;
    case TaskStatus.completed:
      return completedTaskColor;

    default:
      return upcomingTaskColor;
  }
}

String getTaskTileStatusString(TaskStatus? status) {
  switch (status) {
    case TaskStatus.todo:
      return 'TODO';
    case TaskStatus.inProgress:
      return 'IN PROGRESS';
    case TaskStatus.onHold:
      return 'ON HOLD';
    case TaskStatus.completed:
      return 'COMPLETED';
    default:
      return 'TODO';
  }
}

String getTaskTileTypeString(TaskType? taskType) {
  switch (taskType) {
    case TaskType.open:
      return 'OPEN';
    case TaskType.closed:
      return 'DISPOSED';
    default:
      return 'CLOSED';
  }
}

String formatDate(DateTime? date) {
  if (date == null) {
    return ""; // Handle null date case
  }
  return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
}

String getStatusSmallString(TaskStatus? status) {
  switch (status) {
    case TaskStatus.todo:
      return 'todo';
    case TaskStatus.inProgress:
      return 'inProgress';
    case TaskStatus.onHold:
      return 'onHold';
    case TaskStatus.completed:
      return 'completed';
    default:
      return 'todo';
  }
}

String getTypeSmallString(TaskType? taskType) {
  switch (taskType) {
    case TaskType.open:
      return 'open';
    case TaskType.closed:
      return 'closed';
    default:
      return 'closed';
  }
}
