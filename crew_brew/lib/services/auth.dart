import 'package:crew_brew/firebase_options.dart';
import 'package:crew_brew/models/UserModel.dart';
import 'package:crew_brew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserModel?> get userStream {
    return _auth
        .authStateChanges()
        .map((User? user) => userModelFromUser(user));
  }

  UserModel? userModelFromUser(User? user) {
    return user == null ? null : UserModel(uid: user.uid);
  }

  //sign in with google
  /*Future<String?> signInGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }*/

  Future SignInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return userModelFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password

  Future RegisterWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User? user = result.user;
      await database(uid: user!.uid).updateUserData('0', 'اسم شلفي', 200);
      return userModelFromUser(user);
    } catch (e) {
      return null;
    }
  }

  Future SignInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User? user = result.user;
      return userModelFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future<void> signOutFromGoogle() async {
    //await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
