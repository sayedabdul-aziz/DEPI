import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/repo/auth_repo.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_event.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on((event, emit) async {
      if (event is LoginEvent) {
        await login(event, emit);
      } else if (event is SignUpEvent) {
        await signUp(event, emit);
      } else if (event is DoctorRegistrationEvent) {
        await updateDoctor(emit);
      }
    });
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final bioController = TextEditingController();
  final openHourController = TextEditingController();
  final closeHourController = TextEditingController();
  final addressController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();
  String? specialization;
  String imageUrl = '';

  signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    var result = await AuthRepo.signUp(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      userType: event.userType,
    );
    result.fold(
      (error) {
        emit(AuthErrorState(error));
      },
      (data) {
        emit(AuthSuccessState(data));
      },
    );
  }

  login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    var result = await AuthRepo.login(
      email: emailController.text,
      password: passwordController.text,
    );
    result.fold(
      (error) {
        emit(AuthErrorState(error));
      },
      (data) {
        emit(AuthSuccessState(data));
      },
    );
  }

  updateDoctor(Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    var result = await AuthRepo.updateDoctorData(
      DoctorModel(
        uid: SharedPref.getUserId(),
        bio: bioController.text,
        openHour: openHourController.text,
        closeHour: closeHourController.text,
        address: addressController.text,
        phone1: phone1Controller.text,
        phone2: phone2Controller.text,
        specialization: specialization,
        image: imageUrl,
      ),
    );
    result.fold(
      (error) {
        emit(AuthErrorState(error));
      },
      (data) {
        emit(DoctorRegistrationSuccessState());
      },
    );
  }
}

// Auth (small DB) => id, name, email, password, phone, image
// Firestore (Big DB) => id, name, email, password, phone, image, openHours, closedHours, location
