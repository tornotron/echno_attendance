import 'package:echno_attendance/constants/colors_string.dart';
import 'package:flutter/material.dart';

class Employee {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? userRole;
  bool? isActiveUser;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.userRole,
    required this.isActiveUser,
  });
}

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
  Employee? _foundEmployee;

  void _searchEmployee() {
    // Replace this with your logic to fetch employee details from a database or API
    // For simplicity, I'm using a hardcoded list of employees
    List<Employee?> employees = [
      Employee(
        id: '1',
        name: 'Sam Smith',
        email: 'samsmith@echno.com',
        phoneNumber: '1234567890',
        userRole: 'Software Engineer',
        isActiveUser: true,
      ),
      Employee(
        id: '2',
        name: 'Jane Doe',
        email: 'janedoe@echno.com',
        phoneNumber: '1234567890',
        userRole: 'Product Manager',
        isActiveUser: true,
      ),
    ];

    // Find the employee with the given ID
    String searchId = _employeeIdController.text;
    Employee? foundEmployee = employees.firstWhere(
        (Employee? employee) => employee?.id == searchId,
        orElse: () => null);

    setState(() {
      _foundEmployee = foundEmployee;
    });

    // Show error dialog if employee not found
    if (foundEmployee == null) {
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
                    onPressed: _searchEmployee,
                    child: const Text('Search'),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Divider(height: 2.0),
                const SizedBox(height: 10.0),
                if (_foundEmployee != null)
                  Column(
                    children: [
                      TextFormField(
                        initialValue: _foundEmployee!.name,
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
                            _foundEmployee!.name = value;
                          });
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        initialValue: _foundEmployee!.email,
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
                            _foundEmployee!.email = value;
                          });
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        initialValue: _foundEmployee!.phoneNumber,
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
                            _foundEmployee!.phoneNumber = value;
                          });
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        initialValue: _foundEmployee!.userRole,
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
                            _foundEmployee!.userRole = value;
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
                            value: _foundEmployee!.isActiveUser!,
                            onChanged: (value) {
                              setState(() {
                                _foundEmployee!.isActiveUser = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
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
