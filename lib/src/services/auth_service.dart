import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signInAnon() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      User user = userCredential.user;
      String uid = user.uid;
      return uid;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'signed in';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<User> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
