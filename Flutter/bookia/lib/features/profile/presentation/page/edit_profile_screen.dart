import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_field.dart';
import 'package:bookia/core/extentions/dialogs.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:bookia/features/profile/presentation/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProfileCubit>();
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoading) {
            showLoadingDialog(context);
          } else if (state is ProfileError) {
            pop(context);
            showMyDialog(context, state.message);
          } else if (state is ProfileLoaded) {
            pop(context);
            pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // profile image with edit icon
                ProfileImage(),
                Gap(50),
                // form fields
                CustomTextField(
                  controller: cubit.nameController,
                  hintText: "Full Name",
                ),
                Gap(20),
                CustomTextField(
                  controller: cubit.addressController,
                  hintText: "Address",
                ),
                Gap(20),
                CustomTextField(
                  controller: cubit.phoneController,
                  hintText: "Phone",
                ),
                Gap(70),

                MainButton(
                  text: "Save",
                  onPressed: () {
                    cubit.updateProfile();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
