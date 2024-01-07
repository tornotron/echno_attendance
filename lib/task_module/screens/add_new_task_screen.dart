import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/task_module/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  final _taskProvider = TaskService.firestoreTasks();

  // Variable for current date
  final String _currentDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  double _taskProgress = 0.0;

  // Controllers for text form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  // Controllers for dropdowns
  final TextEditingController _taskTypeController = TextEditingController();
  final TextEditingController _assignedEmployeeController =
      TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  // Controller for linear progress indicator
  final TextEditingController _taskProgressController =
      TextEditingController(text: '0.0');

  // Form key for validation
  final _addTaskFormKey = GlobalKey<FormState>();

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

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _taskTypeController.dispose();
    _assignedEmployeeController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor),
        backgroundColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor,
        title: const Text('Add Task'),
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
          padding: AddTaskScreen.containerPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add New Task',
                  style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 15.0),
              Form(
                  key: _addTaskFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Title',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: 'Enter the task title...',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Task Description',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        controller: _descriptionController,
                        minLines: 3,
                        maxLines:
                            null, // Allows for an adjustable number of lines
                        decoration: const InputDecoration(
                          hintText: 'Enter task description...',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Current Date',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5.0),
                      TextField(
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: _currentDate,
                          hintStyle: Theme.of(context).textTheme.titleMedium,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Start Date',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 5.0),
                                // Start Date Date Picker
                                TextFormField(
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
                                          DateFormat("dd-MM-yyyy")
                                              .format(pickedDate);
                                      _endDateController
                                          .clear(); // Reset end date when start date changes
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Start Date',
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
                                Text(
                                  'End Date',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 5.0),
                                // End Date Date Picker
                                TextFormField(
                                  controller: _endDateController,
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedStartDate =
                                        DateFormat("dd-MM-yyyy")
                                            .parse(_startDateController.text);
                                    DateTime initialDate = pickedStartDate;

                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2030),
                                    );

                                    if (pickedDate != null) {
                                      if (pickedDate
                                          .isBefore(pickedStartDate)) {
                                        _showErrorDialog(
                                            'End date cannot be earlier than the start date');
                                      } else {
                                        _endDateController.text =
                                            DateFormat("dd-MM-yyyy")
                                                .format(pickedDate);
                                      }
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'End Date',
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.calendar_month),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'End Date is required';
                                    }

                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Task Type',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5.0),
                      // Task Type Dropdown
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
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Task Status',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5.0),

                      // Status Dropdown
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
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Task Progress',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5.0),
                      // Task Progress Linear Progress Indicator
                      TextFormField(
                        controller: _taskProgressController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _taskProgress = double.tryParse(value) ?? 0.0;
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
                        value: _taskProgress,
                        onChanged: (value) {
                          setState(() {
                            _taskProgress = value;
                            _taskProgressController.text =
                                value.toStringAsFixed(2);
                          });
                        },
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: _taskProgress.round().toString(),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Assign Task',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5.0),
                      // Assigned Employee Dropdown
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
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      // Button to submit leave application
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_addTaskFormKey.currentState?.validate() ??
                                false) {
                              final title = _titleController.text;
                              final description = _descriptionController.text;
                              final createdAt =
                                  DateFormat("dd-MM-yyyy").parse(_currentDate);
                              final startDate = DateFormat("dd-MM-yyyy")
                                  .parse(_startDateController.text);
                              final endDate = DateFormat("dd-MM-yyyy")
                                  .parse(_endDateController.text);
                              const taskAuthor =
                                  'Current Employee'; // From the currentEmployye function
                              final taskType = _taskTypeController.text;
                              final taskStatus = _statusController.text;
                              final taskProgress = _taskProgress;
                              final assignedEmployee =
                                  _assignedEmployeeController.text;
                              const siteOffice =
                                  'Ernakulam'; // From the currentEmployye function
                              await _taskProvider.addNewTask(
                                title: title,
                                description: description,
                                createdAt: createdAt,
                                startDate: startDate,
                                endDate: endDate,
                                taskAuthor: taskAuthor,
                                taskType: taskType,
                                taskStatus: taskStatus,
                                taskProgress: taskProgress,
                                assignedEmployee: assignedEmployee,
                                siteOffice: siteOffice,
                              );
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: echnoGreenColor,
                                    content: Text('New Task Added..!'),
                                  ),
                                );
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
                            }
                          },
                          child: const Text('Create New Task'),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
