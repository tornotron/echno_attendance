import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/task_module/screens/task_home_screen.dart';
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

  late TextEditingController _progressController;
  double? _progressSliderValue = 0.0;
  String? _selectedStatus = '';

  @override
  void initState() {
    _progressController =
        TextEditingController(text: widget.task?.taskProgress.toString());
    _progressSliderValue = widget.task?.taskProgress;
    _selectedStatus = getStatusSmallString(widget.task?.status);
    super.initState();
  }

  @override
  void dispose() {
    _progressController.dispose();
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
                value: _selectedStatus,
                onChanged: (String? value) {
                  setState(() {
                    _selectedStatus = value;
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
                controller: _progressController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _progressSliderValue = double.tryParse(value) ?? 0.0;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Task Progress (%)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              Slider(
                value: _progressSliderValue!,
                onChanged: (value) {
                  setState(() {
                    _progressSliderValue = value;
                    _progressController.text = value.toStringAsFixed(2);
                  });
                },
                min: 0,
                max: 100,
                divisions: 100,
                label: _progressSliderValue?.round().toString(),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await _taskProvider.updateTaskProgress(
                      taskId: task!.id,
                      newTaskStatus: _selectedStatus.toString(),
                      newTaskProgress: _progressSliderValue,
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: echnoGreenColor,
                          content: Text('Task Updated..!'),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskHomeScreen(
                              index:
                                  getTaskHomeIndex(_selectedStatus.toString())),
                        ),
                      );
                    }
                    // Clear the controllers after form submission
                    setState(() {
                      _progressController.clear();
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
