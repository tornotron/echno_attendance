import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/task_module/screens/add_new_task_screen.dart';
import 'package:echno_attendance/task_module/screens/task_details_screen.dart';
import 'package:echno_attendance/task_module/services/task_model.dart';
import 'package:echno_attendance/task_module/services/task_service.dart';
import 'package:echno_attendance/task_module/utilities/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TaskHomeScreen extends StatefulWidget {
  const TaskHomeScreen({Key? key}) : super(key: key);
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<TaskHomeScreen> createState() => _TaskHomeScreenState();
}

class _TaskHomeScreenState extends State<TaskHomeScreen> {
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  final _taskProvider = TaskService.firestoreTasks();

  int _selectedIndex = 1;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor),
        backgroundColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor,
        title: const Text('Task Manager'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: TaskHomeScreen.containerPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text('Today',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                SizedBox(
                  width: 120.00,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddTaskScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      '+ Add Task',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildCategoryButton(0, 'On Hold'),
                        buildCategoryButton(1, 'Ongoing'),
                        buildCategoryButton(2, 'Upcoming'),
                        buildCategoryButton(3, 'Completed'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            const Divider(height: 3.0, color: Colors.grey),
            const SizedBox(height: 10.0),
            StreamBuilder<List<Task>>(
              stream: _taskProvider.streamTasksBySiteOffice(
                  siteOffice: 'Ernakulam'),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No Task Found...!',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  List<Task>? tasks = snapshot.data;
                  TaskStatus selectedCategory =
                      getSelectedCategory(_selectedIndex);
                  tasks = tasks
                      ?.where((task) => task.status == selectedCategory)
                      .toList();
                  if (tasks == null || tasks.isEmpty) {
                    return Center(
                      child: Text(
                        'No Task With This Status...!',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemExtent: 170.0,
                        itemBuilder: (context, index) {
                          final taskData = tasks?[index];
                          return InkWell(
                            child: TaskTile(taskData),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TaskDetailsScreen(task: taskData),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryButton(int index, String text) {
    Brightness themeMode = Theme.of(context).brightness;
    Color selectedColor =
        themeMode == Brightness.dark ? echnoLightBlueColor : echnoLogoColor;
    Color unselectedColor = echnoGreyColor;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: _selectedIndex == index ? selectedColor : unselectedColor,
            border: const Border(
                left: BorderSide(width: 0.1), right: BorderSide(width: 0.1))),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'TT Chocolates Bold',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  TaskStatus getSelectedCategory(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return TaskStatus.onHold;
      case 1:
        return TaskStatus.inProgress;
      case 2:
        return TaskStatus.todo;
      case 3:
        return TaskStatus.completed;

      default:
        return TaskStatus.todo;
    }
  }
}
