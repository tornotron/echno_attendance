import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'package:echno_attendance/leave_module/services/leave_services.dart';
import 'package:echno_attendance/leave_module/utilities/leave_cancel_dialog.dart';
import 'package:echno_attendance/leave_module/utilities/leave_status.dart';
import 'package:echno_attendance/leave_module/utilities/leave_type.dart';
import 'package:echno_attendance/leave_module/utilities/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget leaveStatusCard(
  Leave leave,
  bool isDarkMode,
  BuildContext context,
) {
  final leaveProvider = LeaveService.firestoreLeave();
  final String formatedFromDate =
      DateFormat('dd-MM-yyyy').format(leave.fromDate);
  final String formatedToDate = DateFormat('dd-MM-yyyy').format(leave.toDate);
  final String appliedDate = DateFormat('dd-MM-yyyy').format(leave.appliedDate);
  final thumbnail = Container(
    alignment: const FractionalOffset(0.0, 0.5),
    margin: const EdgeInsets.only(left: 15.0),
    child: Hero(
      tag: leave.id,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: echnoDarkColor,
          border: Border.all(
            width: 5,
            color: getColor(leave.leaveStatus, leave.isCancelled),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: getIcon(leave.leaveStatus, leave.isCancelled),
        ),
      ),
    ),
  );

  final leaveCard = Container(
    height: 200,
    margin: const EdgeInsets.only(left: 45.0, right: 20.0),
    decoration: BoxDecoration(
      color: isDarkMode ? echnoLightBlueColor : echnoBlueColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: isDarkMode ? echnoGreyColor : echnoLightColor,
          blurRadius: 5.0,
          offset: const Offset(0.5, 3.0),
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
            getLeaveTypeName(leave.leaveType),
            style: const TextStyle(
              color: echnoDarkColor,
              fontFamily: 'TT Chocolates Bold',
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            '$formatedFromDate - $formatedToDate',
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
                leave.isCancelled
                    ? 'Cancelled'
                    : getLeaveStatusName(leave.leaveStatus),
                style: const TextStyle(
                  color: echnoDarkColor,
                  fontFamily: 'TT Chocolates Bold',
                  fontWeight: FontWeight.w300,
                  fontSize: 14.0,
                ),
              ),
              Container(width: 70.0),
              leave.leaveStatus == LeaveStatus.approved ||
                      leave.leaveStatus == LeaveStatus.rejected ||
                      leave.isCancelled
                  ? Container(
                      height: 35,
                    )
                  : GestureDetector(
                      onTap: () async {
                        final shouldCancel = await showCancelDialog(context);
                        if (shouldCancel) {
                          await leaveProvider.cancelLeave(leaveId: leave.id);
                        }
                      },
                      child: Container(
                        width: 60.0,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: leaveCancelButtonColor,
                        ),
                        child: const Column(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_upward,
                              size: 20.0,
                              color: echnoDarkColor,
                            ),
                            Text(
                              leaveStatusCancelButtonLabel,
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
            "$leaveAppliedOnFieldLabel $appliedDate",
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
