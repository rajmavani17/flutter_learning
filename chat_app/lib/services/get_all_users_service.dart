import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firebaseFirestore = FirebaseFirestore.instance;

class GetAllUsersService {
  static Future<List<UserModel>> getAllUsers() async {
    final response = await _firebaseFirestore.collection('users').get();
    final List<UserModel> data = response.docs.map((item) {
      return UserModel(
        email: item['email'],
        imageUrl: item['image_url'],
        username: item['username'],
        uid: item['uid'],
      );
    }).toList();
    return data;
  }
}
