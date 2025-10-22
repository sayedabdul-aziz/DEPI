import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/inputs/custom_text_field.dart';
import 'package:se7ety/core/extentions/dialogs.dart';
import 'package:se7ety/core/extentions/image_uploader.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/specializations.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_event.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_state.dart';

class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  State<DoctorRegistrationScreen> createState() =>
      _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  String? _imagePath;
  File? file;
  String? profileUrl;

  String? userID;

  // Database , Cloud

  //* to upload image to firestore
  // 1) upload image to storage (Firebase Storage / Supabase storage / Cloudinary)
  // 2) get image url from storage
  // 3) update image url in firestore

  // doctors/729348014014912.png

  // uploadImageToFirebaseStorage(File image, String imageName) async {
  //   try {
  //     Reference ref = FirebaseStorage.instanceFor(
  //       bucket: 'gs://easy-doc-e56b4.appspot.com',
  //     ).ref().child('test/${FirebaseAuth.instance.currentUser!.uid}');

  //     SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
  //     await ref.putFile(image, metadata);
  //     String url = await ref.getDownloadURL();
  //     log(url);
  //     return url;
  //   } on Exception catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<AuthBloc>();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoadingDialog(context);
        } else if (state is DoctorRegistrationSuccessState) {
          pop(context);
        } else if (state is AuthErrorState) {
          pop(context);
          showMyDialog(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('إكمال عملية التسجيل')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: bloc.formKey,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            // backgroundColor: AppColors.lightBg,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: (_imagePath != null)
                                  ? FileImage(File(_imagePath!))
                                  : const AssetImage('assets/images/doc.png'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _pickImage();
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Theme.of(
                                context,
                              ).scaffoldBackgroundColor,
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                size: 20,
                                // color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                        child: Row(
                          children: [
                            Text(
                              'التخصص',
                              style: TextStyles.body.copyWith(
                                color: AppColors.darkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // التخصص---------------
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButton<String?>(
                          isExpanded: true,
                          iconEnabledColor: AppColors.primaryColor,
                          hint: Text(
                            'اختر التخصص',
                            style: TextStyles.body.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                          icon: const Icon(Icons.expand_circle_down_outlined),
                          value: bloc.specialization,
                          onChanged: (String? newValue) {
                            setState(() {
                              bloc.specialization = newValue;
                            });
                          },
                          items: [
                            for (var specialization in specializations)
                              DropdownMenuItem(
                                value: specialization,
                                child: Text(specialization),
                              ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'نبذة تعريفية',
                              style: TextStyles.body.copyWith(
                                color: AppColors.darkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                        controller: bloc.bioController,
                        maxLines: 4,
                        hintText:
                            'سجل المعلومات الطبية العامة مثل تعليمك الأكاديمي وخبراتك السابقة...',

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل النبذة التعريفية';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'عنوان العيادة',
                              style: TextStyles.body.copyWith(
                                color: AppColors.darkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                        controller: bloc.addressController,
                        hintText: '5 شارع مصدق - الدقي - الجيزة',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل عنوان العيادة';
                          } else {
                            return null;
                          }
                        },
                      ),
                      _workHours(bloc),

                      _phoneNumbers(bloc),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(top: 25.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: MainButton(
              onPressed: () async {
                if (bloc.formKey.currentState!.validate()) {
                  if (file != null) {
                    bloc.imageUrl =
                        await uploadImageToCloudinary(
                          file!,
                          "dup0vzih4",
                          "se7ety",
                        ) ??
                        '';

                    bloc.add(DoctorRegistrationEvent());
                  } else {
                    showMyDialog(
                      context,
                      'من فضلك قم باختيار صورة الصفحة الشخصية',
                    );
                  }
                }
              },
              text: "التسجيل",
            ),
          ),
        ),
      ),
    );
  }

  Column _workHours(AuthBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'ساعات العمل من',
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'الي',
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            // ---------- Start Time ----------------
            Expanded(
              child: CustomTextField(
                readOnly: true,
                controller: bloc.openHourController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'مطلوب';
                  } else {
                    return null;
                  }
                },
                suffixIcon: IconButton(
                  onPressed: () async {
                    await showStartTimePicker(bloc);
                  },
                  icon: const Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),

                hintText: '00:00',
              ),
            ),
            const SizedBox(width: 10),

            // ---------- End Time ----------------
            Expanded(
              child: CustomTextField(
                readOnly: true,
                controller: bloc.closeHourController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'مطلوب';
                  } else {
                    return null;
                  }
                },
                suffixIcon: IconButton(
                  onPressed: () async {
                    await showEndTimePicker(bloc);
                  },
                  icon: const Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),

                hintText: '00:00',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _phoneNumbers(AuthBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'رقم الهاتف 1',
                style: TextStyles.body.copyWith(color: AppColors.darkColor),
              ),
            ],
          ),
        ),
        CustomTextField(
          controller: bloc.phone1Controller,
          keyboardType: TextInputType.number,
          hintText: '+20xxxxxxxxxx',

          validator: (value) {
            if (value!.isEmpty) {
              return 'من فضلك ادخل الرقم';
            } else {
              return null;
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'رقم الهاتف 2 (اختياري)',
                style: TextStyles.body.copyWith(color: AppColors.darkColor),
              ),
            ],
          ),
        ),
        CustomTextField(
          controller: bloc.phone2Controller,
          keyboardType: TextInputType.number,
          hintText: '+20xxxxxxxxxx',
        ),
      ],
    );
  }

  Future<void> showStartTimePicker(AuthBloc bloc) async {
    final startTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTimePicked != null) {
      bloc.openHourController.text = startTimePicked.hour.toString();
    }
  }

  Future<void> showEndTimePicker(AuthBloc bloc) async {
    final endTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now().add(const Duration(minutes: 15)),
      ),
    );

    if (endTimePicked != null) {
      bloc.closeHourController.text = endTimePicked.hour.toString();
    }
  }
}
