import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class TimeFieldSelection extends StatelessWidget {
  const TimeFieldSelection({
    super.key,
    required this.controller,
    required this.text,
    required this.onTap,
  });

  final TextEditingController controller;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: TextStyles.getBody(fontWeight: FontWeight.w600)),
          Gap(6),
          TextFormField(
            controller: controller,
            onTap: onTap,
            readOnly: true,
            decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.watch_later_outlined,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
