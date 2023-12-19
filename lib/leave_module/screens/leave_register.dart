import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/leave_module/services/leave_services.dart';
import 'package:echno_attendance/leave_module/utilities/ui_helper.dart';
import 'package:flutter/material.dart';

class LeaveRegisterScreen extends StatefulWidget {
  const LeaveRegisterScreen({Key? key}) : super(key: key);
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<LeaveRegisterScreen> createState() => LeaveRegisterScreenState();
}

class LeaveRegisterScreenState extends State<LeaveRegisterScreen> {
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  final TextEditingController _searchController = TextEditingController();
  final _leaveProvider = LeaveService.firestoreLeave();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? echnoLightBlueColor : echnoLogoColor,
        title: const Text('Leave Register'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: LeaveRegisterScreen.containerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Employee Leave Register',
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.left,
                ),
                Text(
                  'List of all the leaves applied by the employees...',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    labelText: 'Filter',
                    hintText: 'Start Typing...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    // Trigger filtering when the user types
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10.0),
                const Divider(height: 3.0),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _leaveProvider.fetchLeaves(),
              builder: (context, snapshot) {
                List<Map<String, dynamic>> filteredLeaves = [];

                if (snapshot.hasData) {
                  filteredLeaves = snapshot.data!
                      .where((leaveData) =>
                          (leaveData['leaveType']?.toLowerCase()?.contains(
                                  _searchController.text.toLowerCase()) ??
                              false) ||
                          (leaveData['employeeName']?.toLowerCase()?.contains(
                                  _searchController.text.toLowerCase()) ??
                              false) ||
                          (leaveData['employeeId']?.toLowerCase()?.contains(
                                  _searchController.text.toLowerCase()) ??
                              false) ||
                          (leaveData['leaveStatus']?.toLowerCase()?.contains(
                                  _searchController.text.toLowerCase()) ??
                              false))
                      .toList();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                      children: [
                        const Center(child: LinearProgressIndicator()),
                        const SizedBox(height: 10),
                        Text(
                          'Loading...',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (filteredLeaves.isEmpty) {
                  return Center(
                    child: Text(
                      'No matching leave data found.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: filteredLeaves.length,
                    itemExtent: 170.0,
                    itemBuilder: (context, index) {
                      final leaveData = filteredLeaves[index];
                      return leaveRow(leaveData);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget leaveRow(Map<String, dynamic> leaveData) {
    final leaveCard = Container(
      height: 200,
      margin: const EdgeInsets.only(left: 25.0, right: 25.0),
      decoration: BoxDecoration(
        color: isDarkMode ? echnoLightBlueColor : echnoLogoColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: isDarkMode ? echnoGreyColor : echnoLightColor,
            blurRadius: 10.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(top: 16.0, left: 40.0),
          constraints: const BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                leaveData['employeeName'],
                style: const TextStyle(
                  color: echnoDarkColor,
                  fontFamily: 'TT Chocolates Bold',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                leaveData['leaveType'],
                style: const TextStyle(
                  color: echnoDarkColor,
                  fontFamily: 'TT Chocolates Bold',
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                'Duration : ${leaveData['fromDate']}  -  ${leaveData['toDate']}',
                style: const TextStyle(
                  color: echnoDarkColor,
                  fontFamily: 'TT Chocolates Bold',
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text('Status : ',
                      style: TextStyle(
                        color: echnoDarkColor,
                        fontFamily: 'TT Chocolates Bold',
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      )),
                  const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.calendar_today,
                      size: 14.0,
                      color: echnoDarkColor,
                    ),
                  ),
                  Text(
                    leaveData['isCancelled'] == false
                        ? getStatus(leaveData['leaveStatus'])
                        : 'Cancelled',
                    style: const TextStyle(
                      color: echnoDarkColor,
                      fontFamily: 'TT Chocolates Bold',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                "Applied On: ${leaveData['appliedDate']}",
                style: const TextStyle(
                  color: echnoDarkColor,
                  fontFamily: 'TT Chocolates Bold',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Stack(
        children: <Widget>[
          leaveCard,
        ],
      ),
    );
  }
}
