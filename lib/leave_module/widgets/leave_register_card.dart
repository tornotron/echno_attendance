import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'package:echno_attendance/leave_module/screens/leave_approval_screen.dart';
import 'package:echno_attendance/leave_module/utilities/leave_status.dart';
import 'package:echno_attendance/leave_module/utilities/leave_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget leaveRow(
  Leave leave,
  bool isDarkMode,
  BuildContext context,
) {
  final leaveRegisterCard = Container(
    height: 200,
    margin: const EdgeInsets.only(left: 25.0, right: 25.0),
    decoration: BoxDecoration(
      color: isDarkMode ? echnoLightBlueColor : echnoBlueColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(8.0),
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
        leaveRegisterCard,
      ],
    ),
  );
}
