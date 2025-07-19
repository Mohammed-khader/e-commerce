import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:first_project/core/local/local_storage_service.dart';
import 'package:first_project/core/local/user_data.dart';

class ChangeProfileRepo {
  Future<Either<String, void>> updateProfileData(
    String username,
    String phone,
    String email,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserDataService.uid)
          .update({
        'username': username,
        'phone': phone,
      });
      LocalStorageService.instance.setPhone(phone);
      UserDataService.phone = phone;
      LocalStorageService.instance.setUsername(username);
      UserDataService.username = username;
      LocalStorageService.instance.setEmail(email);
      UserDataService.email = email;
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
