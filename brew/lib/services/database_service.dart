import 'dart:ffi';

import 'package:brew/models/brew_model.dart';
import 'package:brew/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService(this.uid);
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    final response = await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
    return response;
  }

  List<BrewModel> _brewListFromSnapshot(QuerySnapshot? snapshot) {
    if (snapshot == null) return <BrewModel>[];
    return snapshot.docs.map((doc) {
      return BrewModel(
        name: (doc.data() as Map<String, dynamic>)['name'] ?? '',
        sugars: (doc.data() as Map<String, dynamic>)['sugars'] ?? '',
        strength: (doc.data() as Map<String, dynamic>)['strength'] ?? 0,
      );
    }).toList();
  }

  UserDataModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataModel(
      uid: uid ?? '',
      name: (snapshot.data() as Map<String, dynamic>)['name'],
      sugars: (snapshot.data() as Map<String, dynamic>)['sugars'],
      strength: (snapshot.data() as Map<String, dynamic>)['strength'],
    );
  }

  Stream<List<BrewModel>> get brews {
    return brewCollection.snapshots().map((e) => _brewListFromSnapshot(e));
  }

  Stream<UserDataModel> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
