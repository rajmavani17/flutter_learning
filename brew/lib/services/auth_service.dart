import 'package:brew/models/user_model.dart';
import 'package:brew/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromFirebase(User? user) {
    if (user != null) {
      UserModel userModel = UserModel(
        uid: user.uid,
      );
      return userModel;
    }
    return null;
  }

  Stream<UserModel?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebase(user));
  }

  Future signinAnonymous() async {
    try {
      final UserCredential result = await _auth.signInAnonymously();
      final User? user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      await DatabaseService(user!.uid).updateUserData('0', 'new member ', 100);

      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future signinWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
