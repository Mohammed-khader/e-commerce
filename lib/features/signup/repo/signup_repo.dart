import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:first_project/features/signup/model/signup_request_model.dart';

class SignUpRepo {
  Future<Either<String, UserCredential>> createAccountRequest({
    required String email,
    required String password,
    required String username,
    required String phone,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveUserDataInDataBase(
          signUpData: SignupRequestModel(
        email: credential.user?.email ?? '',
        uid: credential.user?.uid ?? '',
        phone: phone,
        username: username,
      ));
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      return Left(errorMessage);
    }
  }
}

Future<void> _saveUserDataInDataBase({required SignupRequestModel signUpData}) async {
  await FirebaseFirestore.instance.collection('users').doc(signUpData.uid).set(
        signUpData.toJson(),
      );
}
