import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:flutter/material.dart';

class EmployeeRegisterScreen extends StatefulWidget {
  const EmployeeRegisterScreen({Key? key}) : super(key: key);
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<EmployeeRegisterScreen> createState() => _EmployeeRegisterScreenState();
}

class _EmployeeRegisterScreenState extends State<EmployeeRegisterScreen> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  TextEditingController searchController = TextEditingController();

  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode ? echnoLightBlueColor : echnoLogoColor,
          title: const Text('Employee Register'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: EmployeeRegisterScreen.containerPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      (15.0),
                    ),
                  ),
                  labelText: 'Filter',
                  hintText: 'Start Typing...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  // Trigger search when the user types
                  setState(() {});
                },
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: users.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var employees = snapshot.data!.docs;
                    List<Widget> employeeWidgets = [];

                    for (var employee in employees) {
                      var name = employee['full-name'];
                      var employeeId = employee['employee-id'];
                      var email = employee['email-id'];
                      var phone = employee['phone'];
                      var status = employee['employee-status'];

                      if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()) ||
                          employeeId
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()) ||
                          email
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()) ||
                          phone
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                        employeeWidgets.add(
                          Card(
                            color: isDarkMode
                                ? echnoLightBlueColor
                                : echnoLogoColor,
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ListTile(
                              title: Text(
                                name,
                                style: const TextStyle(
                                  color: echnoDarkColor,
                                  fontFamily: 'TT Chocolates Bold',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Employee ID: $employeeId',
                                    style: const TextStyle(
                                      color: echnoDarkColor,
                                      fontFamily: 'TT Chocolates Bold',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                    'Email: $email',
                                    style: const TextStyle(
                                      color: echnoDarkColor,
                                      fontFamily: 'TT Chocolates Bold',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                    'Phone: $phone',
                                    style: const TextStyle(
                                      color: echnoDarkColor,
                                      fontFamily: 'TT Chocolates Bold',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                      'Status: ${status ? 'Active' : 'Inactive'}',
                                      style: const TextStyle(
                                        color: echnoDarkColor,
                                        fontFamily: 'TT Chocolates Bold',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14.0,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }

                    return ListView(
                      children: employeeWidgets,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
