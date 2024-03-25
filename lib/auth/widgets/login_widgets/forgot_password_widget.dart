import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/utilities/alert_dialogue.dart';
import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/constants/static_text.dart';
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
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(EchnoSize.borderRadiusLg)),
            context: context,
            builder: (builderContext) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      EchnoText.resetTitle,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Text(
                      EchnoText.resetSubtitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: EchnoSize.spaceBtwSections),

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
                          borderRadius:
                              BorderRadius.circular(EchnoSize.borderRadiusLg),
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
                                  EchnoText.resetViaEmail,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  EchnoText.resetViaEmailSub,
                                  style: Theme.of(context).textTheme.titleSmall,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: EchnoSize.spaceBtwItems),

                    // Phone Password Reset
                    GestureDetector(
                      onTap: () async {
                        await genericAlertDialog(
                            context, EchnoText.featureDisabled);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(EchnoSize.borderRadiusLg),
                          color: EchnoColors.darkGrey,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.mobile_friendly_rounded,
                              size: 60.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  EchnoText.resetViaPhone,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  EchnoText.resetViaPhoneSub,
                                  style: Theme.of(context).textTheme.titleSmall,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Text(
          EchnoText.forgotPasswordButton,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 14.5,
              color: isDark ? EchnoColors.secondary : EchnoColors.primary),
        ),
      ),
    );
  }
}
