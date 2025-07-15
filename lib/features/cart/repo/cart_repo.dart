import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:first_project/core/local/user_data.dart';
import 'package:first_project/features/product_details/model/products_model.dart';

class CartRepo {
  Future<Either<String, List<ProductsModel>>> getCartItems() async {
    try {
      List<ProductsModel> products = [];
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(UserDataService.uid)
          .collection('cart')
          .get();
      for (var element in result.docs) {
        products.add(ProductsModel.fromJson(element.data()));
      }
      return Right(products);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, void>> updateCount(int count, String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserDataService.uid)
          .collection('cart')
          .doc(productId)
          .update({'count': count});
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, int>> getCount() async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(UserDataService.uid)
          .collection('cart')
          .get();

      return Right(result.docs.length);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, void>> removeProducts(String productID) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserDataService.uid)
          .collection('cart')
          .doc(productID)
          .delete();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
