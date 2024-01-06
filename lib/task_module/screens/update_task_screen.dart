import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/task_module/services/task_model.dart';
import 'package:echno_attendance/task_module/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UpdateTaskScreen extends StatefulWidget {
  final Task? task;
  const UpdateTaskScreen({
    required this.task,
    Key? key,
  }) : super(key: key);
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  Task? get task => widget.task;
  bool _isEditable = false;

  final _taskProvider = TaskService.firestoreTasks();

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
  late double _updatedTaskProgress; // For Slider

  @override
  void initState() {
    _titleController.text = task?.title ?? "";
    _descriptionController.text = task?.description ?? "";
    _createdDateController.text = _formatDate(task?.createdAt);
    _taskAuthorController.text = task?.taskAuthor ?? "";
    _startDateController.text = _formatDate(task?.startDate);
    _endDateController.text = _formatDate(task?.endDate);
    _taskTypeController.text = _getTypeString(task?.taskType);
    _assignedEmployeeController.text = task?.assignedEmployee ?? "";
    _statusController.text = _getStatusString(task?.status);
    _taskProgressController.text = task?.taskProgress.toString() ?? "";
    taskProgress = task?.taskProgress != null ? task!.taskProgress / 100 : null;
    _updatedTaskProgress = task?.taskProgress ?? 0.0;
    super.initState();
  }

  // Function to show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              Text('Error'),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  String _getStatusString(TaskStatus? status) {
    switch (status) {
      case TaskStatus.todo:
        return 'todo';
      case TaskStatus.inProgress:
        return 'inProgress';
      case TaskStatus.onhold:
        return 'onHold';
      case TaskStatus.completed:
        return 'completed';
      default:
        return 'todo';
    }
  }

  String _getTypeString(TaskType? taskType) {
    switch (taskType) {
      case TaskType.open:
        return 'open';
      case TaskType.closed:
        return 'closed';
      default:
        return 'closed';
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return ""; // Handle null date case
    }
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
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
        title: _isEditable
            ? const Text('Update Task')
            : const Text('Task Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            if (_isEditable) {
              setState(() {
                _isEditable = false;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          if (!_isEditable)
            IconButton(
              onPressed: () {
                setState(() {
                  _isEditable = true;
                });
              },
              icon: const Icon(Icons.edit),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: UpdateTaskScreen.containerPadding,
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
                enabled: _isEditable,
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Title',
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                enabled: _isEditable,
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
                enabled: false,
                controller: _createdDateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Created On',
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                enabled: false,
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
                          enabled: _isEditable,
                          controller: _startDateController,
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                            );
                            if (pickedDate != null) {
                              _startDateController.text =
                                  DateFormat("dd-MM-yyyy").format(pickedDate);
                              _endDateController
                                  .clear(); // Reset end date when start date changes
                            }
                          },
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
                          enabled: _isEditable,
                          controller: _endDateController,
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedStartDate = DateFormat("dd-MM-yyyy")
                                .parse(_startDateController.text);
                            DateTime initialDate = pickedStartDate;

                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                            );

                            if (pickedDate != null) {
                              if (pickedDate.isBefore(pickedStartDate)) {
                                _showErrorDialog(
                                    'End date cannot be earlier than the start date');
                              } else {
                                _endDateController.text =
                                    DateFormat("dd-MM-yyyy").format(pickedDate);
                              }
                            }
                          },
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
              if (_isEditable)
                DropdownButtonFormField<String>(
                  value: _taskTypeController.text.isNotEmpty
                      ? _taskTypeController.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      _taskTypeController.text = value ?? '';
                    });
                  },
                  items: const [
                    DropdownMenuItem<String>(
                      value: null,
                      child: Text('Select Type'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'open',
                      child: Text('Open'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'closed',
                      child: Text('Closed'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Task Type',
                  ),
                ),
              if (!_isEditable)
                TextFormField(
                  enabled: _isEditable,
                  controller: _taskTypeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Task Type',
                  ),
                ),
              const SizedBox(height: 15.0),
              if (_isEditable)
                DropdownButtonFormField<String>(
                  value: _statusController.text.isNotEmpty
                      ? _statusController.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      _statusController.text = value ?? '';
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
              if (!_isEditable)
                TextFormField(
                  enabled: _isEditable,
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
              if (!_isEditable)
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
              if (_isEditable)
                Column(
                  children: [
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
                          _taskProgressController.text =
                              value.toStringAsFixed(2);
                        });
                      },
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _updatedTaskProgress.round().toString(),
                    ),
                  ],
                ),
              const SizedBox(height: 15.0),
              if (_isEditable)
                DropdownButtonFormField<String>(
                  value: _assignedEmployeeController.text.isNotEmpty
                      ? _assignedEmployeeController.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      _assignedEmployeeController.text = value ?? '';
                    });
                  },
                  items: const [
                    DropdownMenuItem<String>(
                      value: null,
                      child: Text('Select Employee'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Employee 1',
                      child: Text('Employee 1'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Employee 2',
                      child: Text('Employee 2'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Employee 3',
                      child: Text('Employee 3'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Assign Task',
                    border: OutlineInputBorder(),
                  ),
                ),
              if (!_isEditable)
                TextFormField(
                  enabled: _isEditable,
                  controller: _assignedEmployeeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Assign Task',
                  ),
                ),
              const SizedBox(height: 15.0),
              if (_isEditable)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final taskId = task?.id;
                      final title = _titleController.text;
                      final description = _descriptionController.text;
                      final startDate = DateFormat("dd-MM-yyyy")
                          .parse(_startDateController.text);
                      final endDate = DateFormat("dd-MM-yyyy")
                          .parse(_endDateController.text);
                      final taskType = _taskTypeController.text;
                      final taskStatus = _statusController.text;
                      final taskProgress = _updatedTaskProgress;
                      final assignedEmployee = _assignedEmployeeController.text;

                      await _taskProvider.updateTask(
                        taskId: taskId!,
                        newTitle: title,
                        newDescription: description,
                        newStartDate: startDate,
                        newEndDate: endDate,
                        newTaskType: taskType,
                        newTaskStatus: taskStatus,
                        newTaskProgress: taskProgress,
                        newAssignedEmployee: assignedEmployee,
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
                        _titleController.clear();
                        _descriptionController.clear();
                        _startDateController.clear();
                        _endDateController.clear();
                        _taskTypeController.clear();
                        _assignedEmployeeController.clear();
                        _statusController.clear();
                      });
                    },
                    child: const Text('Update Task'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
