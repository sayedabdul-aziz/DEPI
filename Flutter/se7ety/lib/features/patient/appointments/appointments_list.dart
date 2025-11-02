import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/booking/data/appointment_model.dart';

class MyAppointmentList extends StatefulWidget {
  const MyAppointmentList({super.key});

  @override
  State<MyAppointmentList> createState() => _MyAppointmentListState();
}

class _MyAppointmentListState extends State<MyAppointmentList> {
  void showAlertDialog(BuildContext context, String docID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text("حذف الحجز"),
          content: const Text("هل متاكد من حذف هذا الحجز ؟"),
          actions: [
            TextButton(
              child: const Text("لا"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("نعم"),
              onPressed: () {
                FirestoreServices.deleteAppointment(docID).then((_) {
                  pop(context);
                  setState(() {});
                });
              },
            ),
          ],
        );
      },
    );
  }

  bool _compareDate(DateTime date) {
    DateTime now = DateTime.now();
    if (now.year == date.year &&
        now.month == date.month &&
        now.day == date.day) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: FirestoreServices.getAppointmentsByPatientId(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data!.docs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/no_scheduled.svg',
                        width: 250,
                      ),
                      Text('لا يوجد حجوزات قادمة', style: TextStyles.body),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.docs.length ?? 0,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    AppointmentModel model = AppointmentModel.fromJson(
                      snapshot.data!.docs[index].data() as Map<String, dynamic>,
                    );
                    String documentId = snapshot.data!.docs[index].id;

                    return ExpansionTile(
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      childrenPadding: const EdgeInsets.symmetric(vertical: 10),
                      expandedCrossAxisAlignment: CrossAxisAlignment.end,
                      backgroundColor: AppColors.accentColor,
                      collapsedBackgroundColor: AppColors.accentColor,
                      title: Text(
                        'د. ${model.doctorName}',
                        style: TextStyles.title,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_rounded,
                                  color: AppColors.primaryColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  DateFormat.yMMMMd(
                                    'ar',
                                  ).format(model.date).toString(),
                                  style: TextStyles.body,
                                ),
                                const SizedBox(width: 30),
                                Text(
                                  _compareDate(model.date) ? "اليوم" : "",
                                  style: TextStyles.body.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.watch_later_outlined,
                                  color: AppColors.primaryColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  DateFormat.jm(
                                    'ar',
                                  ).format(model.date).toString(),
                                  style: TextStyles.body,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 5,
                            right: 10,
                            left: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'اسم المريض: ${model.name}',
                                style: TextStyles.body,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    color: AppColors.primaryColor,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(model.location, style: TextStyles.body),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.whiteColor,
                                    backgroundColor: AppColors.redColor,
                                  ),
                                  onPressed: () {
                                    showAlertDialog(context, documentId);
                                  },
                                  child: const Text('حذف الحجز'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
