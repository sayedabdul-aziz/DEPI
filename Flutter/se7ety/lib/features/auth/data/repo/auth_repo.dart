import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/auth/data/models/user_type_enum.dart';

class AuthRepo {
  static Future<Either<String, UserTypeEnum>> signUp({
    required String name,
    required String email,
    required String password,
    required UserTypeEnum userType,
  }) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user!;
      user.updateDisplayName(name);
      SharedPref.setUserId(user.uid);
      // store user data in firestore
      // use PhotoURL param as user type (Role)
      if (userType == UserTypeEnum.doctor) {
        user.updatePhotoURL('2');
        var doctor = DoctorModel(
          name: name,
          email: email,
          uid: user.uid,
          rating: 3,
        );
        await FirestoreServices.createDoctor(doctor);
        return Right(userType);
      } else {
        user.updatePhotoURL('1');
        var patient = PatientModel(name: name, email: email, uid: user.uid);
        await FirestoreServices.createPatient(patient);
        return Right(userType);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left('كلمة المرور ضعيفة');
      } else if (e.code == 'email-already-in-use') {
        return Left('البريد الالكتروني مستخدم بالفعل');
      } else {
        return Left('حدث خطأ ما');
      }
    } catch (e) {
      return Left('حدث خطأ ما');
    }
  }

  static Future<Either<String, UserTypeEnum>> login({
    required String email,
    required String password,
  }) async {
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;

      SharedPref.setUserId(user.uid);

      if (user.photoURL == '1') {
        return Right(UserTypeEnum.patient);
      } else {
        return Right(UserTypeEnum.doctor);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left('البريد الالكتروني غير مستخدم');
      } else if (e.code == 'wrong-password') {
        return Left('كلمة المرور غير صحيحة');
      } else {
        return Left('حدث خطأ ما');
      }
    } catch (e) {
      return Left('حدث خطأ ما');
    }
  }

  static Future<Either<String, bool>> updateDoctorData(
    DoctorModel model,
  ) async {
    try {
      await FirestoreServices.updateDoctor(model);
      return const Right(true);
    } catch (e) {
      return Left('حدث خطأ ما');
    }
  }
}
