import 'package:country_picker/country_picker.dart';
import 'package:echno_attendance/common_widgets/custom_app_bar.dart';
import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/employee/services/hr_employee_service.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';
import 'package:echno_attendance/utilities/helpers/form_validators.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:echno_attendance/utilities/styles/padding_style.dart';
import 'package:flutter/material.dart';

class AddNewEmployee extends StatefulWidget {
  const AddNewEmployee({super.key});

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee> {
  late final TextEditingController _idController;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  EmployeeRole _employeeRole = EmployeeRole.emp;
  bool employeeStatus = true;

  final GlobalKey<FormState> _addEmployeeFormKey = GlobalKey<FormState>();

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

    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(context) {
    final isDark = EchnoHelperFunctions.isDarkMode(context);
    _phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _phoneController.text.length,
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: EchnoAppBar(
          leadingIcon: Icons.arrow_back_ios_new,
          leadingOnPressed: () {
            Navigator.pop(context);
          },
          title: Text(
            'Add Employee',
            style: Theme.of(context).textTheme.headlineSmall?.apply(
                  color: isDark ? EchnoColors.black : EchnoColors.white,
                ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: CustomPaddingStyle.defaultPaddingWithAppbar,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add New Employee',
                      style: Theme.of(context).textTheme.displaySmall),
                  Text(
                    'Create an account for the new employee...',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: EchnoSize.spaceBtwSections),
                  Form(
                    key: _addEmployeeFormKey,
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
                                (EchnoSize.borderRadiusLg),
                              ),
                            ),
                          ),
                          validator: (value) => EchnoValidator.defaultValidator(
                              value, 'Employee ID is required'),
                        ),
                        const SizedBox(height: EchnoSize.spaceBtwInputFields),
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
                                (EchnoSize.borderRadiusLg),
                              ),
                            ),
                          ),
                          validator: (value) => EchnoValidator.defaultValidator(
                              value, 'Employee Name is required'),
                        ),
                        const SizedBox(height: EchnoSize.spaceBtwInputFields),
                        TextFormField(
                          controller: _emailController,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.alternate_email),
                            labelText: 'Email ID',
                            hintText: 'E-Mail',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  EchnoSize.borderRadiusLg),
                            ),
                          ),
                          validator: (value) =>
                              EchnoValidator.validateEmail(value),
                        ),
                        const SizedBox(height: EchnoSize.spaceBtwInputFields),
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
                              borderRadius: BorderRadius.circular(
                                  EchnoSize.borderRadiusLg),
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
                                      color: EchnoColors.success,
                                    ),
                                    child: const Icon(
                                      Icons.done,
                                      color: EchnoColors.white,
                                      size: 20,
                                    ),
                                  )
                                : null,
                          ),
                          validator: (value) =>
                              EchnoValidator.validatePhoneNumber(value),
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
                            validator: (value) =>
                                EchnoValidator.defaultValidator(
                                    value, 'Employee Role is required')),
                        const SizedBox(height: EchnoSize.spaceBtwItems),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: EchnoColors.grey,
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
                              value: employeeStatus,
                              onChanged: (value) {
                                setState(() {
                                  employeeStatus = value;
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
                              String phoneNumber =
                                  "+${selectedCountry.phoneCode}${_phoneController.text.trim()}";
                              if (_addEmployeeFormKey.currentState!
                                  .validate()) {
                                await HrEmployeeService.firestore()
                                    .createEmployee(
                                        employeeId: _idController.text.trim(),
                                        employeeName:
                                            _nameController.text.trim(),
                                        companyEmail:
                                            _emailController.text.trim(),
                                        phoneNumber: phoneNumber,
                                        employeeStatus: employeeStatus,
                                        employeeRole: _employeeRole);
                              }
                              if (context.mounted) {
                                // Clear the controllers after form submission
                                _idController.clear();
                                _nameController.clear();
                                _emailController.clear();
                                _phoneController.clear();
                              }
                            },
                            child: const Text(
                              'Add Employee',
                            ),
                          ),
                        ),
                      ],
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
