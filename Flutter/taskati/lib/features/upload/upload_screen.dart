import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/components/buttons/main_button.dart';
import 'package:taskati/core/extentions/dialogs.dart';
import 'package:taskati/core/utils/colors.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (path != null && nameController.text.isNotEmpty) {
                print('Done');
              } else if (path != null && nameController.text.isEmpty) {
                showErrorDialog(context, 'Please enter your name');
              } else if (path == null && nameController.text.isNotEmpty) {
                showErrorDialog(context, 'Please upload your profile image');
              } else {
                showErrorDialog(
                  context,
                  'Please enter your name and upload your profile image',
                );
              }
            },
            child: Text('Done'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: AppColors.primaryColor,
                  backgroundImage: path != null
                      ? FileImage(File(path ?? ''))
                      : AssetImage('assets/images/user.png'),
                ),
                Gap(20),
                MainButton(
                  width: 250,
                  text: 'Upload From Camera',
                  onPressed: () {
                    uploadImage(true);
                  },
                ),
                Gap(10),
                MainButton(
                  width: 250,
                  text: 'Upload From Gallery',
                  onPressed: () async {
                    uploadImage(false);
                  },
                ),
                Gap(20),
                Divider(),
                Gap(20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Enter your name'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  uploadImage(bool isCamera) async {
    var picker = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (picker != null) {
      setState(() {
        path = picker.path;
      });
    }
  }
}
