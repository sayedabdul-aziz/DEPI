import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/components/cards/doctor_card.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';

// Firestore (Collection => list of docs => (id, data {}))

//! Get Dat
// 1) specific document => Collection + doc id (My Profile)
// 2) list of docs => Collection
// - Sorting => orderBy()
// - Filter => where()
// - search => startAt() + endAt() + //uf8ff
// - pagination => limit()

//! update(), delete()  => Collection + doc id
//! add(), set() => Collection

// FutureBuilder => get()
// StreamBuilder => snapshots()

class TopRatedList extends StatefulWidget {
  const TopRatedList({super.key});

  @override
  State<TopRatedList> createState() => _TopRatedListState();
}

class _TopRatedListState extends State<TopRatedList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: FirestoreServices.sortDoctorsByRating(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                value: .9,
                color: Colors.black12,
              ),
            );
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length, // all doctors in firebase
              itemBuilder: (context, index) {
                DoctorModel doctor = DoctorModel.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>,
                );
                if (doctor.specialization == null ||
                    doctor.specialization?.isEmpty == true) {
                  return const SizedBox();
                }
                return DoctorCard(doctor: doctor);
              },
            );
          }
        },
      ),
    );
  }
}
