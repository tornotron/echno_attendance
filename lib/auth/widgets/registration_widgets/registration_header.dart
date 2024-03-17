import 'package:echno_attendance/constants/image_string.dart';
import 'package:echno_attendance/constants/sizes.dart';
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
          echnoRegister,
          height: 140.0,
        ),
        const SizedBox(height: EchnoSize.spaceBtwItems),
        Text('Get On Board!', style: Theme.of(context).textTheme.displaySmall),
        Text(
          'Create an account to start your Journey ...',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
