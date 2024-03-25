import 'package:echno_attendance/constants/image_strings.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/constants/static_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegistrationScreenHeader extends StatelessWidget {
  const RegistrationScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          EchnoImages.register,
          height: EchnoSize.imageHeaderHeight,
        ),
        const SizedBox(height: EchnoSize.spaceBtwItems),
        Text(EchnoText.registerTitle,
            style: Theme.of(context).textTheme.displaySmall),
        Text(
          EchnoText.registerSubtitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
