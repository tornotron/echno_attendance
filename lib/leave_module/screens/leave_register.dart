import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'package:echno_attendance/leave_module/screens/leave_approval_screen.dart';
import 'package:echno_attendance/leave_module/services/leave_services.dart';
import 'package:echno_attendance/leave_module/utilities/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class LeaveRegisterScreen extends StatefulWidget {
  const LeaveRegisterScreen({super.key});
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
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor),
        backgroundColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor,
        title: const Text(leaveRegisterAppBarTitle),
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
                  leaveRegisterScreenTitle,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.left,
                ),
                Text(
                  leaveRegisterSubtitle,
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
                    labelText: leaveRegisterFilterFieldLabel,
                    hintText: leaveRegisterFilterFieldHint,
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
          leaveCardStreamBuilder(),
        ],
      ),
    );
  }

  Expanded leaveCardStreamBuilder() {
    return Expanded(
      child: StreamBuilder<List<Leave>>(
        stream: _leaveProvider.fetchLeaves(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                leaveRegisterNoLeaveData,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            );
          } else {
            // Order leaves by latest applied date
            final orderedLeaves = snapshot.data!.toList()
              ..sort((a, b) => b.appliedDate.compareTo(a.appliedDate));

            // Filter leaves based on search query
            final filteredLeaves = orderedLeaves.where((leave) {
              final searchQuery = _searchController.text.toLowerCase();
              return getLeaveTypeName(leave.leaveType)
                      .toLowerCase()
                      .contains(searchQuery) ||
                  leave.employeeName.toLowerCase().contains(searchQuery) ||
                  leave.employeeID.toLowerCase().contains(searchQuery) ||
                  leave.leaveStatus!
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery);
            }).toList();

            if (filteredLeaves.isEmpty) {
              return Center(
                child: Text(
                  'No leaves found matching the search criteria.',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              );
            }

            return ListView.builder(
              itemCount: filteredLeaves.length,
              itemBuilder: (context, index) {
                final leave = filteredLeaves[index];
                return leaveRow(leave);
              },
            );
          }
        },
      ),
    );
  }

  Widget leaveRow(Leave leave) {
    final leaveCard = Container(
      height: 200,
      margin: const EdgeInsets.only(left: 25.0, right: 25.0),
      decoration: BoxDecoration(
        color: isDarkMode ? echnoLightBlueColor : echnoBlueColor,
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LeaveApprovalScreen(leave: leave),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(top: 16.0, left: 40.0),
          constraints: const BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                leave.employeeName,
                style: const TextStyle(
                  color: echnoDarkColor,
                  fontFamily: 'TT Chocolates Bold',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                getLeaveTypeName(leave.leaveType),
                style: const TextStyle(
                  color: echnoDarkColor,
                  fontFamily: 'TT Chocolates Bold',
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                '$leaveRegisterDurationFieldLabel ${DateFormat('dd-MM-yyyy').format(leave.fromDate)}  -  ${DateFormat('dd-MM-yyyy').format(leave.toDate)}',
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
                  const Text(leaveRegisterStatusFieldLabel,
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
                    leave.isCancelled == false
                        ? getLeaveStatusName(leave.leaveStatus)
                        : leaveRegisterCancelledStatus,
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
                "$leaveRegisterAppliedFieldLabel ${DateFormat('dd-MM-yyyy').format(leave.appliedDate)}",
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
