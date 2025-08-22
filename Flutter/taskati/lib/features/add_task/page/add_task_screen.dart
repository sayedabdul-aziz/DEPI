import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/components/buttons/main_button.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/add_task/widgets/time_field_selection.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController(
    text: DateFormat("yyyy-MM-dd").format(DateTime.now()),
  );
  var startTimeController = TextEditingController(
    text: DateFormat("hh:mm a").format(DateTime.now()),
  );
  var endTimeController = TextEditingController(
    text: DateFormat("hh:mm a").format(DateTime.now()),
  );

  int selectedColor = 0;

  List<Color> colors = [
    AppColors.primaryColor,
    AppColors.orangeColor,
    AppColors.redColor,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MainButton(height: 55, text: 'Create Task', onPressed: () {}),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyles.getBody(fontWeight: FontWeight.w600),
              ),
              Gap(6),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Enter title'),
              ),
              Gap(12),
              Text(
                'Description',
                style: TextStyles.getBody(fontWeight: FontWeight.w600),
              ),
              Gap(6),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(hintText: 'Enter description ...'),
              ),
              Gap(12),
              dateSelection(),
              Gap(12),
              timeSelection(),
              Gap(12),
              colorSelection(),
            ],
          ),
        ),
      ),
    );
  }

  Column colorSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: TextStyles.getBody(fontWeight: FontWeight.w600)),
        Gap(6),
        Row(
          spacing: 5,
          children: List.generate(colors.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: CircleAvatar(
                backgroundColor: colors[index],
                child: (selectedColor == index)
                    ? Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            );
          }),
        ),
      ],
    );
  }

  Column dateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date', style: TextStyles.getBody(fontWeight: FontWeight.w600)),
        Gap(6),
        TextFormField(
          controller: dateController,
          onTap: () async {
            var selectedDate = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              initialDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365 * 3)),
            );
            if (selectedDate != null) {
              dateController.text = DateFormat(
                "yyyy-MM-dd",
              ).format(selectedDate);
            }
          },
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.calendar_month,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Row timeSelection() {
    return Row(
      children: [
        TimeFieldSelection(
          controller: startTimeController,
          text: 'Start Time',
          onTap: () async {
            var selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (selectedTime != null) {
              startTimeController.text = selectedTime.format(context);
              // var startTime = DateFormat(
              //   "hh:mm:ss a",
              // ).parse(startTimeController.text);
            }
          },
        ),
        Gap(8),
        TimeFieldSelection(
          controller: endTimeController,
          text: 'End Time',
          onTap: () async {
            var selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (selectedTime != null) {
              endTimeController.text = selectedTime.format(context);
            }
          },
        ),
      ],
    );
  }
}
