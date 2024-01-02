import 'package:echno_attendance/constants/colors_string.dart';
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
  DateTime? _startDate; // Starting date of task
  DateTime? _endDate; // Ending date of task

  String? _selectedTaskType = 'Select...';

  List<String> taskTypeList = [
    'Select...',
    'On Hold',
    'Ongoing',
    'Upcoming',
    'Completed',
    'Urgent',
  ];

  String? _selectedAssignee = 'Assign to Employee...';

  List<String> sampleAsigneeList = [
    'Assign to Employee...',
    'Sam Smith',
    'Alex Andrews',
    'Jaiden Smith',
    'Alice Watson',
  ];

  // Function for Task Type Drop Down
  DropdownButtonFormField<String> _taskTypeDropdown() {
    return DropdownButtonFormField<String>(
      icon: const Icon(Icons.keyboard_arrow_down),
      value: _selectedTaskType,
      items: taskTypeList.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedTaskType = newValue;
        });
      },
      decoration: InputDecoration(
        hintText: _selectedTaskType,
        border: const OutlineInputBorder(),
      ),
    );
  }

  // Function for Task Assignee Drop Down
  DropdownButtonFormField<String> _taskAssigneeDropdown() {
    // Remove duplicates from the list
    sampleAsigneeList = sampleAsigneeList.toSet().toList();

    return DropdownButtonFormField<String>(
      icon: const Icon(Icons.keyboard_arrow_down),
      value: _selectedAssignee,
      items: sampleAsigneeList.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedAssignee = newValue;
        });
      },
      decoration: InputDecoration(
        hintText: _selectedAssignee,
        border: const OutlineInputBorder(),
      ),
    );
  }

  // Function selects the start date of task
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (picked.isBefore(DateTime.now())) {
        // Show error dialog for start date before current date
        _showErrorDialog('Start date cannot be earlier than the current date');
      } else {
        setState(() {
          _startDate = picked;
          _endDate = null; // Reset end date when start date changes
        });
      }
    }
  }

  // Function selects the end date of task
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && _startDate != null) {
      if (picked.isBefore(_startDate!)) {
        _showErrorDialog('End date cannot be earlier than the start date');
      } else {
        setState(() {
          _endDate = picked;
        });
      }
    }
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

  @override
  void dispose() {
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
          onPressed: () {},
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
              Text(
                'Task Title',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 5.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter the task title...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Task Description',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 5.0),
              const TextField(
                minLines: 3,
                maxLines: null, // Allows for an adjustable number of lines
                decoration: InputDecoration(
                  hintText: 'Enter task description...',
                  border: OutlineInputBorder(),
                ),
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
                  labelText: DateFormat("dd-MM-yyyy").format(DateTime.now()),
                  labelStyle: Theme.of(context).textTheme.titleMedium,
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
                        GestureDetector(
                          child: TextFormField(
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: _startDate == null
                                  ? 'Select Start Date...'
                                  : DateFormat("dd-MM-yyyy")
                                      .format(_startDate!),
                              labelStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              border: const OutlineInputBorder(),
                              suffixIcon: const Icon(Icons.calendar_month),
                            ),
                          ),
                          onTap: () {
                            _selectStartDate(context);
                          },
                        )
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
                        GestureDetector(
                          child: TextFormField(
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: _endDate == null
                                  ? 'Select End Date...'
                                  : DateFormat("dd-MM-yyyy").format(_endDate!),
                              labelStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              border: const OutlineInputBorder(),
                              suffixIcon: const Icon(Icons.calendar_month),
                            ),
                          ),
                          onTap: () {
                            _selectEndDate(context);
                          },
                        )
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
              _taskTypeDropdown(),
              const SizedBox(height: 10.0),
              Text(
                'Assign Task',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 5.0),
              _taskAssigneeDropdown(),
              const SizedBox(height: 15.0),

              // Button to submit leave application
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Create New Task'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
