import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/core/local/local_database.dart';
import 'package:first_project/features/login/model/login_response_mode.dart';

class LoginRepo {
  Future<Either<String, LoginResponseMode>> loginReporequasr({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final loginResponseMode = await getUserData(uid: credential.user?.uid ?? '');
      return Right(loginResponseMode);
    } on FirebaseAuthException catch (e) {
      return Left(e.message.toString());
    }
  }

  Future<LoginResponseMode> getUserData({required String uid}) async {
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final userData = snapshot.data();
    log('userData: $userData');
    LoginResponseMode loginResponseMode = LoginResponseMode.fomJson(userData);
    //save user data to local database
    await LocalDatabase.instance?.setUserData(loginResponseMode);
    return loginResponseMode;
  }
}
