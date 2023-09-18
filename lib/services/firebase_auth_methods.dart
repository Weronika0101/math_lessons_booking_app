import 'package:booking_app/main/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/showSnackBar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  Stream<User?> get authState => _auth.authStateChanges();

  User get user => _auth.currentUser!;

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context,e.message!);
    }
  }
  //EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
}) async {
    try{
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,);
      if(!_auth.currentUser!.emailVerified) {
        await sendEmailVerification(context);
        //screen informing about email not verified
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //SIGN UP WITH EMAIL
  Future<void> sendEmailVerification(BuildContext context) async {
    try{
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent');
    } on FirebaseAuthException catch (e){
      showSnackBar(context, e.message!);
    }
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const HomeScreen();
    } else {
      return const LoginOrRegisterScreen();
    }
  }

}
