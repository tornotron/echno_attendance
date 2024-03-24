import 'package:echno_attendance/common_widgets/custom_app_bar.dart';
import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/hr_employee_service.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:echno_attendance/utilities/styles/padding_style.dart';
import 'package:flutter/material.dart';

class UpdateEmployeeDetails extends StatefulWidget {
  const UpdateEmployeeDetails({super.key});

  @override
  State<UpdateEmployeeDetails> createState() => _UpdateEmployeeDetailsState();
}

class _UpdateEmployeeDetailsState extends State<UpdateEmployeeDetails> {
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
    final isDark = EchnoHelperFunctions.isDarkMode(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: EchnoAppBar(
          leadingIcon: Icons.arrow_back_ios_new,
          leadingOnPressed: () {
            Navigator.pop(context);
          },
          title: Text(
            'Update Details',
            style: Theme.of(context).textTheme.headlineSmall?.apply(
                  color: isDark ? EchnoColors.black : EchnoColors.white,
                ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: CustomPaddingStyle.defaultPaddingWithAppbar,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 15.0),
                Text('Update Details',
                    style: Theme.of(context).textTheme.displaySmall),
                Text(
                  'Update the personal details the employee...',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: EchnoSize.spaceBtwSections),
                TextField(
                  controller: _employeeIdController,
                  decoration: InputDecoration(
                    labelText: 'Employee ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        (EchnoSize.borderRadiusLg),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: EchnoSize.spaceBtwItems),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _searchEmployee(_employeeIdController.text);
                    },
                    child: const Text('Search'),
                  ),
                ),
                const SizedBox(height: EchnoSize.spaceBtwItems),
                const Divider(height: EchnoSize.dividerHeight),
                const SizedBox(height: EchnoSize.spaceBtwItems),
                if (_employee != null)
                  Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              (EchnoSize.borderRadiusLg),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _employeeName = _nameController.text;
                          });
                        },
                      ),
                      const SizedBox(height: EchnoSize.spaceBtwInputFields),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email-ID',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              (EchnoSize.borderRadiusLg),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _companyEmail = _emailController.text;
                          });
                        },
                      ),
                      const SizedBox(height: EchnoSize.spaceBtwInputFields),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Mobie Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              (EchnoSize.borderRadiusLg),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _phoneNumber = _phoneController.text;
                          });
                        },
                      ),
                      const SizedBox(height: EchnoSize.spaceBtwInputFields),
                      DropdownButtonFormField<EmployeeRole>(
                        value: _employeeRole,
                        onChanged: (EmployeeRole? newValue) {
                          setState(() {
                            _employeeRole = newValue ?? EmployeeRole.tc;
                          });
                        },
                        items: EmployeeRole.values.map((EmployeeRole role) {
                          String roleName = getEmloyeeRoleName(role);
                          return DropdownMenuItem<EmployeeRole>(
                              value: role, // Use enum value here
                              child: Text(roleName));
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Select Employee Role',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: EchnoSize.spaceBtwItems),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: echnoGreyColor,
                            width: 1.50,
                          ),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(EchnoSize.borderRadiusLg)),
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
                      const SizedBox(height: EchnoSize.spaceBtwItems),
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
                                const SnackBar(
                                  backgroundColor: EchnoColors.success,
                                  content:
                                      Text('Details updated successfully!'),
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
