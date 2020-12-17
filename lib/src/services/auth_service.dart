import 'package:crudv3/src/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //create app user based on firebase User
  AppUser _appUserFromUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser> get checkAuthState {
    return firebaseAuth.authStateChanges().map(_appUserFromUser);
  }

  Future<AppUser> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return _appUserFromUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AppUser> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return _appUserFromUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
