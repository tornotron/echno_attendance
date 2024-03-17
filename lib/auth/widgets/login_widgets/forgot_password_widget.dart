import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = EchnoHelperFunctions.isDarkMode(context);
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          /*---------- Forgot Password BottomSheet Start ----------*/

          showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            context: context,
            builder: (builderContext) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reset Password!',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Text(
                      'Choose an option to reset your password...',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    // Email Password Reset

                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(
                              const AuthForgotPasswordEvent(),
                            );
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: EchnoColors.darkGrey,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.mail_outline_outlined,
                              size: 60.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'E-Mail',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  'Reset via E-Mail Verification',
                                  style: Theme.of(context).textTheme.titleSmall,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // Phone Password Reset

                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Container(
                    //     padding: const EdgeInsets.all(
                    //         20.0),
                    //     decoration: BoxDecoration(
                    //       borderRadius:
                    //           BorderRadius.circular(
                    //               15.0),
                    //       color: echnoGreyColor,
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         const Icon(
                    //           Icons
                    //               .mobile_friendly_rounded,
                    //           size: 60.0,
                    //         ),
                    //         const SizedBox(
                    //           width: 10.0,
                    //         ),
                    //         Column(
                    //           crossAxisAlignment:
                    //               CrossAxisAlignment
                    //                   .start,
                    //           children: [
                    //             Text(
                    //               'Phone Number',
                    //               style: Theme.of(
                    //                       context)
                    //                   .textTheme
                    //                   .titleLarge,
                    //             ),
                    //             Text(
                    //               'Reset via Phone Verification',
                    //               style: Theme.of(
                    //                       context)
                    //                   .textTheme
                    //                   .titleSmall,
                    //             )
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Text(
          'Forgot Password ?',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 14.5,
              color: isDark ? EchnoColors.secondary : EchnoColors.primary),
        ),
      ),
    );
  }
}
