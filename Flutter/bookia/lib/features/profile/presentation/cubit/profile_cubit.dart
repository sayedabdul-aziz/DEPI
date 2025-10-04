import 'package:bookia/core/services/local/local_helper.dart';
import 'package:bookia/features/profile/data/model/update_profile_params.dart';
import 'package:bookia/features/profile/data/repo/profile_repo.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();

  initData() {
    var userData = LocalHelper.getUserData();
    nameController.text = userData?.name ?? '';
    addressController.text = userData?.address ?? '';
    phoneController.text = userData?.phone ?? '';
  }

  updateProfile() async {
    emit(ProfileLoading());

    var params = UpdateProfileParams(
      name: nameController.text,
      address: addressController.text,
      phone: phoneController.text,
    );

    var res = await ProfileRepo.updateProfile(params);

    if (res) {
      emit(ProfileLoaded());
    } else {
      emit(ProfileError(message: "Failed to update profile"));
    }
  }
}
