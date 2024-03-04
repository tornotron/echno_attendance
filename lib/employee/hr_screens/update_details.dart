import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/employee/hr_service.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  Map<String, dynamic>? _employeeData;

  void _searchEmployee(String employeeId) async {
    final employeeData = await HrService().readUser(employeeId: employeeId);
    setState(() {
      _employeeData = employeeData;

      if (employeeData.isNotEmpty) {
        _nameController.text = employeeData['name'] ?? '';
        _emailController.text = employeeData['email'] ?? '';
        _phoneController.text = employeeData['phoneNumber'] ?? '';
        _roleController.text = employeeData['userRole'] ?? '';
      }
    });

    // Show error dialog if employee not found
    if (employeeData['id'] == null) {
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
                _employeeIdController.clear();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _employeeIdController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _roleController.dispose();
    super.dispose();
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
                if (_employeeData?['id'] != null)
                  Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
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
                            _employeeData?['name'] = _nameController.text;
                          });
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        controller: _emailController,
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
                            _employeeData?['email'] = _emailController.text;
                          });
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        controller: _phoneController,
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
                            _employeeData?['phoneNumber'] =
                                _phoneController.text;
                          });
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        controller: _roleController,
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
                            _employeeData?['userRole'] = _roleController.text;
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
                            value: _employeeData?['isActiveUser'] ?? false,
                            onChanged: (value) {
                              setState(() {
                                _employeeData?['isActiveUser'] = value;
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
                            await HrService().updateUser(
                              employeeId: _employeeIdController.text,
                              name: _employeeData?['name'],
                              email: _employeeData?['email'],
                              phoneNumber: _employeeData?['phoneNumber'],
                              userRole: _employeeData?['userRole'],
                              isActiveUser: _employeeData?['isActiveUser'],
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
                                _nameController.clear();
                                _emailController.clear();
                                _phoneController.clear();
                                _roleController.clear();
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
