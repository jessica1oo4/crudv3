import 'package:crudv3/src/models/app_user.dart';
import 'package:crudv3/src/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirestoreService firestoreService = FirestoreService();

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
      AppUser appUser = _appUserFromUser(user);

      firestoreService.createUser(appUser);

      return appUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AppUser> getAppUser() async {
    User user = await firebaseAuth.currentUser;
    return _appUserFromUser(user);
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
