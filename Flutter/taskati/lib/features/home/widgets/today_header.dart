import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/components/buttons/main_button.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/add_task/page/add_task_screen.dart';

class TodayHeader extends StatelessWidget {
  const TodayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyles.getTitle(fontWeight: FontWeight.w600),
              ),
              Text(
                DateFormat.EEEE().format(DateTime.now()),
                style: TextStyles.getTitle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Gap(10),
        MainButton(
          width: 138,
          text: '+ Add Task',
          onPressed: () {
            pushTo(context, AddEditTaskScreen());
          },
        ),
      ],
    );
  }
}
