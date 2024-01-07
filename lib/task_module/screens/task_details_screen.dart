import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/task_module/screens/update_task_screen.dart';
import 'package:echno_attendance/task_module/services/task_model.dart';
import 'package:echno_attendance/task_module/utilities/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task? task;
  const TaskDetailsScreen({
    required this.task,
    Key? key,
  }) : super(key: key);
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  Task? get task => widget.task;

  // Controllers for text form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _createdDateController = TextEditingController();
  final TextEditingController _taskAuthorController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  // Controllers for dropdowns
  final TextEditingController _taskTypeController = TextEditingController();
  final TextEditingController _assignedEmployeeController =
      TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  // Controller for linear progress indicator
  final TextEditingController _taskProgressController = TextEditingController();

  double? taskProgress; // For Linear Progress Indicator

  @override
  void initState() {
    _titleController.text = task?.title ?? "";
    _descriptionController.text = task?.description ?? "";
    _createdDateController.text = formatDate(task?.createdAt);
    _taskAuthorController.text = task?.taskAuthor ?? "";
    _startDateController.text = formatDate(task?.startDate);
    _endDateController.text = formatDate(task?.endDate);
    _taskTypeController.text = getTaskTileTypeString(task?.taskType);
    _assignedEmployeeController.text = task?.assignedEmployee ?? "";
    _statusController.text = getTaskTileStatusString(task?.status);
    _taskProgressController.text = task?.taskProgress.toString() ?? "";
    taskProgress = task?.taskProgress != null ? task!.taskProgress / 100 : null;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _createdDateController.dispose();
    _taskAuthorController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _taskTypeController.dispose();
    _assignedEmployeeController.dispose();
    _statusController.dispose();
    _taskProgressController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor),
        backgroundColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor,
        title: const Text('Task Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateTaskScreen(task: task),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: TaskDetailsScreen.containerPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Task Details...',
                  style: Theme.of(context).textTheme.displaySmall),
              Text(
                'Detailed information of the task selected...',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 15.0),
              const SizedBox(height: 5.0),
              TextFormField(
                readOnly: true,
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Title',
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                readOnly: true,
                controller: _descriptionController,
                minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Description',
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                readOnly: true,
                controller: _createdDateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Created On',
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                readOnly: true,
                controller: _taskAuthorController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Author',
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Start Date Date Picker
                        TextFormField(
                          controller: _startDateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Start Date',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_month),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Start Date is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // End Date Date Picker
                        TextFormField(
                          controller: _endDateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'End Date',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_month),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                readOnly: true,
                controller: _taskTypeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Type',
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                readOnly: true,
                controller: _statusController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Status',
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                'Task Progress',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: taskProgress,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    "${(task?.taskProgress)}% ",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                readOnly: true,
                controller: _assignedEmployeeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Assign Task',
                ),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
