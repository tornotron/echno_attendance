import 'package:country_picker/country_picker.dart';
import 'package:echno_attendance/auth/services/auth_services/auth_service.dart';
import 'package:echno_attendance/auth/services/auth_services/auth_user.dart';
import 'package:echno_attendance/employee/models/hr_employee.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:flutter/material.dart';

class AddNewEmployee extends StatefulWidget {
  const AddNewEmployee({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee> {
  final AuthUser _currentUser = AuthService.firebase().currentUser!;
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  late final TextEditingController _idController;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _roleController;
  bool isActive = true; // employee account status

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  @override
  void initState() {
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _roleController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _roleController.dispose();

    super.dispose();
  }

  @override
  Widget build(context) {
    _phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _phoneController.text.length,
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode ? echnoLightBlueColor : echnoLogoColor,
          title: const Text('Add Employee'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: AddNewEmployee.containerPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*---------- Register Screen Header Start ----------*/

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15.0),
                      Text('Add New Employee',
                          style: Theme.of(context).textTheme.displaySmall),
                      Text(
                        'Create an account for the new employee...',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Form(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _idController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.tag_rounded),
                              labelText: 'Employee-ID',
                              hintText: 'EMP-1234',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  (15.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            controller: _nameController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.person_outline_outlined),
                              labelText: 'Full Name',
                              hintText: 'Full Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  (15.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            controller: _emailController,
                            enableSuggestions: false,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            decoration: InputDecoration(
                              // filled: true,
                              // fillColor:
                              // const Color.fromARGB(255, 214, 214, 214),
                              prefixIcon: const Icon(Icons.alternate_email),
                              labelText: 'Email ID',
                              hintText: 'E-Mail',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            controller: _phoneController,
                            onChanged: (value) {
                              setState(() {
                                _phoneController.text = value;
                              });
                            },
                            enableSuggestions: false,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                              hintText: '1234 567 890',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(13.5),
                                child: InkWell(
                                  onTap: () {
                                    showCountryPicker(
                                      context: context,
                                      countryListTheme:
                                          const CountryListThemeData(
                                        bottomSheetHeight: 550,
                                      ),
                                      onSelect: (value) {
                                        setState(() {
                                          selectedCountry = value;
                                        });
                                      },
                                    );
                                  },
                                  child: Text(
                                    "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                              suffixIcon: _phoneController.text.length > 9
                                  ? Container(
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.all(10.0),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                      child: const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            controller: _roleController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.cases_rounded),
                              labelText: 'Employee Role',
                              hintText: 'Employee Role',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  (15.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
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
                                value: isActive,
                                onChanged: (value) {
                                  setState(() {
                                    isActive = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                String phoneNumber =
                                    "+${selectedCountry.phoneCode}${_phoneController.text.trim()}";

                                await HrEmployee(user: _currentUser)
                                    .createEmployee(
                                        employeeId: _idController.text.trim(),
                                        name: _nameController.text.trim(),
                                        email: _emailController.text.trim(),
                                        phoneNumber: phoneNumber,
                                        userRole: _roleController.text.trim(),
                                        isActiveUser: isActive);

                                // Clear the controllers after form submission
                                _idController.clear();
                                _nameController.clear();
                                _emailController.clear();
                                _phoneController.clear();
                                _roleController.clear();
                              },
                              child: const Text(
                                'Add Employee',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
