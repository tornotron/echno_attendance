import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/task_module/services/task_model.dart';
import 'package:echno_attendance/task_module/services/task_service.dart';
import 'package:echno_attendance/task_module/utilities/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateTaskProgessScreen extends StatefulWidget {
  final Task? task;
  const UpdateTaskProgessScreen({
    required this.task,
    Key? key,
  }) : super(key: key);
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<UpdateTaskProgessScreen> createState() =>
      _UpdateTaskProgessScreenState();
}

class _UpdateTaskProgessScreenState extends State<UpdateTaskProgessScreen> {
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  Task? get task => widget.task;

  final _taskProvider = TaskService.firestoreTasks();

  final TextEditingController _assignedEmployeeController =
      TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  // Controller for linear progress indicator
  final TextEditingController _taskProgressController = TextEditingController();

  double? taskProgress; // For Linear Progress Indicator
  late double _updatedTaskProgress; // For Slider

  late Map<String, dynamic> _updatedProgress; // For updating task data

  @override
  void initState() {
    _assignedEmployeeController.text = task?.assignedEmployee ?? "";
    _statusController.text = getStatusSmallString(task?.status);
    _taskProgressController.text = task?.taskProgress.toString() ?? "";
    taskProgress = task?.taskProgress != null ? task!.taskProgress / 100 : null;
    _updatedTaskProgress = task?.taskProgress ?? 0.0;
    super.initState();
  }

  @override
  void dispose() {
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
        title: const Text('Update Task'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: UpdateTaskProgessScreen.containerPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Update Task Progress...',
                  style: Theme.of(context).textTheme.displaySmall),
              Text(
                'Update progress of the task selected...',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 15.0),
              DropdownButtonFormField<String>(
                value: _statusController.text.isNotEmpty
                    ? _statusController.text
                    : null,
                onChanged: (String? value) {
                  setState(() {
                    _statusController.text = value ?? '';
                    _updatedProgress['task-status'] = value;
                  });
                },
                items: const [
                  DropdownMenuItem<String>(
                    value: null,
                    child: Text('Select Status'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'todo',
                    child: Text('TODO'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'inProgress',
                    child: Text('In Progress'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'onHold',
                    child: Text('On Hold'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'completed',
                    child: Text('Completed'),
                  ),
                ],
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
              TextFormField(
                controller: _taskProgressController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _updatedTaskProgress = double.tryParse(value) ?? 0.0;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Task Progress (%)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Task Progress is required';
                  }
                  double numericValue = double.tryParse(value) ?? -1;
                  if (numericValue < 0 || numericValue > 100) {
                    return 'Task Progress must be between 0 and 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              Slider(
                value: _updatedTaskProgress,
                onChanged: (value) {
                  setState(() {
                    _updatedTaskProgress = value;
                    _taskProgressController.text = value.toStringAsFixed(2);
                    _updatedProgress['task-progress'] = value;
                  });
                },
                min: 0,
                max: 100,
                divisions: 100,
                label: _updatedTaskProgress.round().toString(),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final taskId = task?.id;

                    await _taskProvider.updateTask(
                      taskId: taskId!,
                      newTaskStatus: _updatedProgress['task-status'],
                      newTaskProgress: _updatedProgress['task-progress'],
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: echnoGreenColor,
                          content: Text('Task Updated..!'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                    // Clear the controllers after form submission
                    setState(() {
                      _assignedEmployeeController.clear();
                      _statusController.clear();
                    });
                  },
                  child: const Text('Update Task Progress'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
