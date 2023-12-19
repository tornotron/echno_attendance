import 'package:echno_attendance/auth/services/auth_service.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/leave_module/services/leave_services.dart';
import 'package:echno_attendance/leave_module/utilities/leave_cancel_dialog.dart';
import 'package:echno_attendance/leave_module/utilities/ui_helper.dart';
import 'package:flutter/material.dart';

class LeaveStatusScreen extends StatefulWidget {
  const LeaveStatusScreen({Key? key}) : super(key: key);
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<LeaveStatusScreen> createState() => LeaveStatusScreenState();
}

class LeaveStatusScreenState extends State<LeaveStatusScreen> {
  final currentUserId = AuthService.firebase().currentUser?.uid;
  final _leaveProvider = LeaveService.firestoreLeave();
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? echnoLightBlueColor : echnoLogoColor,
        title: const Text('Leave Status'),
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
            padding: LeaveStatusScreen.containerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Leave Status...',
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.left,
                ),
                Text(
                  'List of all the leaves applied by you...',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10.0),
                const Divider(height: 3.0),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _leaveProvider.streamLeaveHistory(uid: currentUserId),
              builder: (context, snapshot) {
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
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No matching leave data found.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemExtent: 170.0,
                    itemBuilder: (context, index) {
                      final employeeLeaveData = snapshot.data![index];
                      return leaveRow(employeeLeaveData);
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

  Widget leaveRow(Map<String, dynamic> employeeLeaveData) {
    final thumbnail = Container(
      alignment: const FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 15.0),
      child: Hero(
        tag: employeeLeaveData['leave-id'],
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: echnoDarkColor,
            border: Border.all(
                width: 5,
                color: getColor(employeeLeaveData['leaveStatus'],
                    employeeLeaveData['isCancelled'])),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: getIcon(employeeLeaveData['leaveStatus'],
                employeeLeaveData['isCancelled']),
          ),
        ),
      ),
    );

    final leaveCard = Container(
      height: 200,
      margin: const EdgeInsets.only(left: 45.0, right: 20.0),
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
      child: Container(
        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
        constraints: const BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              employeeLeaveData['leaveType'],
              style: const TextStyle(
                color: echnoDarkColor,
                fontFamily: 'TT Chocolates Bold',
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              employeeLeaveData['fromDate'] +
                  " - " +
                  employeeLeaveData['toDate'],
              style: const TextStyle(
                color: echnoDarkColor,
                fontFamily: 'TT Chocolates Bold',
                fontWeight: FontWeight.w300,
                fontSize: 15.0,
              ),
            ),
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.calendar_today,
                    size: 14.0,
                    color: echnoDarkColor,
                  ),
                ),
                Text(
                  employeeLeaveData['isCancelled'] == false
                      ? getStatus(employeeLeaveData['leaveStatus'])
                      : 'Cancelled',
                  style: const TextStyle(
                    color: echnoDarkColor,
                    fontFamily: 'TT Chocolates Bold',
                    fontWeight: FontWeight.w300,
                    fontSize: 14.0,
                  ),
                ),
                Container(width: 70.0),
                employeeLeaveData['leaveStatus'] == 'approved' ||
                        employeeLeaveData['leaveStatus'] == 'rejected' ||
                        employeeLeaveData['isCancelled'] == true
                    ? Container(
                        height: 35,
                      )
                    : GestureDetector(
                        onTap: () async {
                          final shouldCancel = await showCancelDialog(context);
                          if (shouldCancel) {
                            await _leaveProvider.cancelLeave(
                                leaveId: employeeLeaveData['leave-id']);
                          }
                        },
                        child: Container(
                          width: 60.0,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.purple.shade200,
                          ),
                          child: const Column(
                            children: <Widget>[
                              Icon(
                                Icons.arrow_upward,
                                size: 20.0,
                                color: echnoDarkColor,
                              ),
                              Text(
                                'Cancel',
                                style: TextStyle(
                                  color: echnoDarkColor,
                                  fontFamily: 'TT Chocolates Bold',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
              ],
            ),
            const SizedBox(height: 5.0),
            Text(
              "Applied On: ${employeeLeaveData['appliedDate']}",
              style: const TextStyle(
                color: echnoDarkColor,
                fontFamily: 'TT Chocolates Bold',
                fontWeight: FontWeight.w600,
                fontSize: 12.0,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Stack(
        children: <Widget>[
          leaveCard,
          thumbnail,
        ],
      ),
    );
  }
}
