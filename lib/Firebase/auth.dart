import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:covid/theme/localdb.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

//Sign in function
Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    // Sign in with credential
    final userCredential = await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;
    assert(!user!.isAnonymous);
    final User? currentUser = await _auth.currentUser;
    assert(currentUser!.uid == user!.uid);
    print(user);
    //Set user details
    LocalDataSaver.saveLoginData(false);
    LocalDataSaver.saveName(user!.displayName.toString());
    LocalDataSaver.saveEmail(user.email.toString());
    LocalDataSaver.saveName(user.photoURL.toString());
    return user;
  } catch (e) {
    print(e);
  }
}
