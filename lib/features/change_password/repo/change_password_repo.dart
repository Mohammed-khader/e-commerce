import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/core/local/user_data.dart';

class ChangePasswordRepo {
  Future<Either<String, String>> changePassword(
    String newPassword,
    String oldPassword,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: UserDataService.email ?? '',
        password: oldPassword,
      );
      await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
      return const Right('Change Password Successfully');
    } on FirebaseAuthException catch (_) {
      return const Left('Old Password is not correct');
    }
  }
}
