import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/core/local/local_storage_service.dart';
import 'package:first_project/features/login/model/login_response_mode.dart';

class LoginRepo {
  Future<Either<String, LoginResponseModel>> loginRepoRequast({
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

  Future<LoginResponseModel> getUserData({required String uid}) async {
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final userData = snapshot.data();
    log('userData: $userData');
    LoginResponseModel loginResponseModel = LoginResponseModel.fomJson(userData);
    //save user data to local database
    await LocalStorageService.instance.setUserData(loginResponseModel);
    return loginResponseModel;
  }
}
