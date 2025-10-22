import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';

class FirestoreProvider {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _patientCollection = _firestore.collection(
    'patient',
  );
  static final CollectionReference _doctorCollection = _firestore.collection(
    'doctor',
  );

  static createDoctor(DoctorModel doctor) {
    _doctorCollection.doc(doctor.uid).set(doctor.toJson());
  }

  static createPatient(PatientModel patient) {
    _patientCollection.doc(patient.uid).set(patient.toJson());
  }

   static updateDoctor(DoctorModel doctor) {
    _doctorCollection.doc(doctor.uid).update(doctor.toUpdateData());
  }

  static getDoctorById(String id) {
    return _doctorCollection.doc(id).get();
  }
}
