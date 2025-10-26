import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/extentions/image_uploader.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/patient/search/widgets/item_tile.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  String? _imagePath;
  File? file;

  String? userId;

  Future<void> _getUser() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  Future<void> _pickImage() async {
    _getUser();
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
    String? profileUrl = await uploadImageToCloudinary(file!);
    FirebaseFirestore.instance.collection('patient').doc(userId).update({
      'image': profileUrl,
    });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: const Text('الحساب الشخصي'),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.settings, color: AppColors.whiteColor),
            onPressed: () {
              pushTo(context, Routes.settings);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('patient')
              .doc(userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            PatientModel model = PatientModel.fromJson(
              snapshot.data!.data() as Map<String, dynamic>,
            );
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColors.whiteColor,
                              child: CircleAvatar(
                                backgroundColor: AppColors.whiteColor,
                                radius: 60,
                                backgroundImage:
                                    (model.image?.isNotEmpty == true)
                                    ? NetworkImage(model.image!)
                                    : (_imagePath != null)
                                    ? FileImage(File(_imagePath!))
                                          as ImageProvider
                                    : const AssetImage(AppImages.emptyDocSvg),
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
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${model.name}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.title,
                              ),
                              const SizedBox(height: 10),
                              (model.city?.isNotEmpty == true)
                                  ? Text(
                                      "${model.city}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.body,
                                    )
                                  : MainButton(
                                      text: 'تعديل الحساب',
                                      height: 40,
                                      onPressed: () {},
                                    ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "نبذه تعريفيه",
                      style: TextStyles.body.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      model.bio?.isNotEmpty == true
                          ? model.bio ?? ''
                          : 'لم تضاف',
                      style: TextStyles.small,
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Text(
                      "معلومات التواصل",
                      style: TextStyles.body.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.accentColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TileWidget(
                            text: model.email ?? 'لم تضاف',
                            icon: Icons.email,
                          ),
                          const SizedBox(height: 15),
                          TileWidget(
                            text: model.phone?.isNotEmpty == true
                                ? model.phone ?? ''
                                : 'لم تضاف',
                            icon: Icons.call,
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                    Text(
                      "حجوزاتي",
                      style: TextStyles.body.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const MyAppointmentsHistory(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
