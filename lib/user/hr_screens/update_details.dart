import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/user/hr_user.dart';
import 'package:flutter/material.dart';

class UpdateEmployeeDetails extends StatefulWidget {
  const UpdateEmployeeDetails({Key? key}) : super(key: key);
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<UpdateEmployeeDetails> createState() => _UpdateEmployeeDetailsState();
}

class _UpdateEmployeeDetailsState extends State<UpdateEmployeeDetails> {
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  final TextEditingController _employeeIdController = TextEditingController();

  Map<String, dynamic>? _employeeData;

  void _searchEmployee(String employeeId) async {
    final employeeData = await HrClass().readUser(userId: employeeId);
    setState(() {
      _employeeData = employeeData;
    });

    // Show error dialog if employee not found
    if (employeeData.isEmpty) {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Employee Not Found'),
          content: const Text('No employee found with the provided ID.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode ? echnoLightBlueColor : echnoLogoColor,
          title: const Text('Update Details'),
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
            padding: UpdateEmployeeDetails.containerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15.0),
                    Text('Update Details',
                        style: Theme.of(context).textTheme.displaySmall),
                    Text(
                      'Update the account details the employee...',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                TextField(
                  controller: _employeeIdController,
                  decoration: InputDecoration(
                    labelText: 'Employee ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        (15.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _searchEmployee(_employeeIdController.text);
                    },
                    child: const Text('Search'),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Divider(height: 2.0),
                const SizedBox(height: 10.0),
                if (_employeeData != null && _employeeData!.isNotEmpty)
                  Column(
                    children: [
                      TextFormField(
                        initialValue: _employeeData!['name'],
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              (15.0),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _employeeData!['name'] = value;
                          });
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        initialValue: _employeeData!['email'],
                        decoration: InputDecoration(
                          labelText: 'Email-ID',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              (15.0),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _employeeData!['email'] = value;
                          });
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        initialValue: _employeeData!['phoneNumber'],
                        decoration: InputDecoration(
                          labelText: 'Mobie Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              (15.0),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _employeeData!['phoneNumber'] = value;
                          });
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        initialValue: _employeeData!['userRole'],
                        decoration: InputDecoration(
                          labelText: 'Role',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              (15.0),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _employeeData!['userRole'] = value;
                          });
                        },
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: echnoGreyColor,
                            width: 1.50,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: ListTile(
                          title: Text(
                            'Account Status',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          trailing: Switch(
                            value: _employeeData!['isActiveUser'],
                            onChanged: (value) {
                              setState(() {
                                _employeeData!['isActiveUser'] = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await HrClass().updateUser(
                              userId: _employeeIdController.text,
                              name: _employeeData!['name'],
                              email: _employeeData!['email'],
                              phoneNumber: _employeeData!['phoneNumber'],
                              userRole: _employeeData!['userRole'],
                              isActiveUser: _employeeData!['isActiveUser'],
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green.shade600,
                                  content: const Text(
                                      'Details updated successfully!'),
                                ),
                              );
                              // Clear the fields once the details are updated successfully
                              setState(() {
                                _employeeData = null;
                                _employeeIdController.clear();
                              });
                            }
                          },
                          child: const Text('Update Details'),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
