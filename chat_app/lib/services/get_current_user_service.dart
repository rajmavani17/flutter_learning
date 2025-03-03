import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseFirestore.instance;
final _firebaseAuth = FirebaseAuth.instance;

class GetCurrentUserService {
  static final currentUserId = _firebaseAuth.currentUser!.uid;
  static Future<UserModel> getCurrentUserDetails() async {
    final response =
        await _firebase.collection('users').doc(currentUserId).get();
    final user = UserModel(
      email: response.data()!['email'],
      imageUrl: response.data()!['image_url'],
      username: response.data()!['username'],
      uid: response.data()!['uid'],
    );
    return user;
  }
}
