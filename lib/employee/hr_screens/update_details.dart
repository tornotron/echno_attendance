import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/hr_employee_service.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';
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

  Employee? _employee;
  String? _employeeName;
  String? _companyEmail;
  String? _phoneNumber;
  bool? _employeeStatus;
  EmployeeRole? _employeeRole;

  void _searchEmployee(String employeeId) async {
    final employee = await HrEmployeeService.firestore()
        .readEmployee(employeeId: employeeId);

    _employeeName = employee?.employeeName;
    _companyEmail = employee?.companyEmail;
    _phoneNumber = employee?.phoneNumber;
    _employeeStatus = employee?.employeeStatus;
    _employeeRole = employee?.employeeRole;

    setState(() {
      _employee = employee;

      _nameController.text = _employeeName ?? '';
      _emailController.text = _companyEmail ?? '';
      _phoneController.text = _phoneNumber ?? '';
    });

    // Show error dialog if employee not found
    if (employee == null) {
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
                if (_employee != null)
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
                            _employeeName = _nameController.text;
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
                            _companyEmail = _emailController.text;
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
                            _phoneNumber = _phoneController.text;
                          });
                        },
                      ),
                      const SizedBox(height: 15.0),
                      DropdownButtonFormField<EmployeeRole>(
                        value: _employeeRole,
                        onChanged: (EmployeeRole? newValue) {
                          setState(() {
                            _employeeRole = newValue ?? EmployeeRole.tc;
                          });
                        },
                        items: EmployeeRole.values.map((EmployeeRole role) {
                          return DropdownMenuItem<EmployeeRole>(
                              value: role, // Use enum value here
                              child: Text(
                                role.toString().split('.').last,
                              ));
                        }).toList(),
                        decoration: const InputDecoration(
                          hintText: 'Select Employee Role',
                          border: OutlineInputBorder(),
                        ),
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
                            value: _employeeStatus ?? false,
                            onChanged: (bool value) {
                              setState(() {
                                _employeeStatus = value;
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
                            await HrEmployeeService.firestore().updateEmployee(
                              employeeId: _employeeIdController.text,
                              employeeName: _employeeName,
                              companyEmail: _companyEmail,
                              phoneNumber: _phoneNumber,
                              employeeRole: _employeeRole,
                              employeeStatus: _employeeStatus,
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
                                _employee = null;
                                _employeeIdController.clear();
                                _nameController.clear();
                                _emailController.clear();
                                _phoneController.clear();
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
