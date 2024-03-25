import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/constants/sizes.dart';
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
  final String startDate = DateFormat('dd-MM-yyyy').format(leave.fromDate);
  final String endDate = DateFormat('dd-MM-yyyy').format(leave.toDate);
  final String appliedDate = DateFormat('dd-MM-yyyy').format(leave.appliedDate);
  final leaveRegisterCard = Container(
    height: 170.0,
    margin: const EdgeInsets.only(left: 16.0, right: 16.0),
    decoration: BoxDecoration(
      color: isDarkMode
          ? EchnoColors.black.withOpacity(0.9)
          : EchnoColors.lightCard,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(EchnoSize.borderRadiusMd),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: isDarkMode ? EchnoColors.darkShadow : EchnoColors.lightShadow,
          blurRadius: 10.0,
          spreadRadius: 2.0,
          offset: const Offset(0, 5),
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
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode
                        ? EchnoColors.leaveText
                        : EchnoColors.leaveText,
                  ),
            ),
            const SizedBox(height: 5.0),
            Text(
              getLeaveTypeName(leave.leaveType),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 17.0,
                    fontWeight: FontWeight.normal,
                    color: isDarkMode
                        ? EchnoColors.leaveText
                        : EchnoColors.leaveText,
                  ),
            ),
            const SizedBox(height: 5.0),
            Text(
              '$leaveRegisterDurationFieldLabel $startDate  --  $endDate',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode
                        ? EchnoColors.leaveText
                        : EchnoColors.leaveText,
                  ),
            ),
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  leaveRegisterStatusFieldLabel,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: isDarkMode
                            ? EchnoColors.leaveText
                            : EchnoColors.leaveText,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.calendar_today,
                    size: 14.0,
                    color: isDarkMode
                        ? EchnoColors.leaveText
                        : EchnoColors.leaveText,
                  ),
                ),
                Text(
                  leave.isCancelled == false
                      ? getLeaveStatusName(leave.leaveStatus)
                      : leaveRegisterCancelledStatus,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode
                            ? EchnoColors.leaveText
                            : EchnoColors.leaveText,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              "$leaveRegisterAppliedFieldLabel $appliedDate",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                    color: isDarkMode
                        ? EchnoColors.leaveText
                        : EchnoColors.leaveText,
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
