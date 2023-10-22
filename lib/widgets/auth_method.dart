import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/navbar.dart';

class MyAuthMethods {
  //creating an instance
  final FirebaseAuth _auth;
  MyAuthMethods(this._auth);
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  Future<void> mySignupUser(
      {required String email,
      required String password,
      required String username,
      required BuildContext context}) async {
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        //register user
        final UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final User? user = cred.user;

        var userData = {
          'username': username,
          'uid': user!.uid,
          'password': password,
          'email': email,
        };

        users.doc(user.uid).get().then((doc) {
          if (doc.exists) {
            //old user
            doc.reference.update(userData);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavBar()),
            );
          } else {
            //new user
            users.doc(user.uid).set(userData);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavBar()),
            );
          }
        });

        await mySendEmailVerification(context);
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  //Email Login
  Future<void> myLoginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!_auth.currentUser!.emailVerified) {
        await mySendEmailVerification(context);
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  //Email Verification
  Future<void> mySendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      Fluttertoast.showToast(
        msg: "Email verification link sent!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }
}
