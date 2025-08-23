import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/constants/task_colors.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/add_task/page/add_task_screen.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onComplete,
    required this.onDelete,
  });

  final TaskModel task;
  final Function() onComplete;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onComplete();
        } else {
          onDelete();
        }
      },
      background: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.check, color: AppColors.whiteColor),
            Gap(10),
            Text(
              'Complete',
              style: TextStyles.getBody(color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.redColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: AppColors.whiteColor),
            Gap(10),
            Text(
              'Delete',
              style: TextStyles.getBody(color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          pushTo(context, AddEditTaskScreen(taskModel: task));
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: task.isCompleted ? Colors.green : taskColors[task.color],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.getTitle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Gap(6),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: AppColors.whiteColor,
                          size: 17,
                        ),
                        Gap(6),
                        Text(
                          '${task.startTime} : ${task.endTime}',
                          style: TextStyles.getSmall(
                            color: AppColors.whiteColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    if (task.description?.isNotEmpty == true) ...[
                      Gap(6),
                      Text(
                        task.description ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.getBody(color: AppColors.whiteColor),
                      ),
                    ],
                  ],
                ),
              ),
              Gap(8),
              Container(width: 1, height: 60, color: AppColors.whiteColor),
              Gap(5),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  task.isCompleted ? 'COMPLETED' : 'TODO',
                  style: TextStyles.getSmall(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
