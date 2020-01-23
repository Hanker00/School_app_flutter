import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_project/models/user.dart';
import 'package:school_project/screens/services/database.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FireBaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // gets current user
  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }


  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  }



  // Sign in Anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user); 
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with Email & passowrd
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(0,"name not set", 'no school');
      return _userFromFirebaseUser(user);

    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut(); 
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}
