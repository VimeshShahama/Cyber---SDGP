import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class GoogleSignInProvider extends ChangeNotifier {

  final googleSignIn = GoogleSignIn();
  late bool _isSignIngIn;

  GoogleSignInProvider() {
    _isSignIngIn = false;
  }

  bool get isSigningIn => _isSignIngIn;

  set isSigningIn(bool isSigningIn){

    _isSignIngIn = isSigningIn;
    notifyListeners();

  }

  

  Future login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    // ignore: unnecessary_null_comparison
    if (user == null){
      isSigningIn = false;
      return;
    }
    else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      isSigningIn = false;
    }
  }


  void logOut() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();


  }

}
