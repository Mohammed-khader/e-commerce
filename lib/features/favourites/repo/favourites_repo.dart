import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:first_project/core/local/user_data.dart';
import 'package:first_project/features/product_details/model/products_model.dart';

class FavouritesRepo {
  Future<Either<String, List<ProductsModel>>> getFavourites() async {
    List<ProductsModel> favoriteProduct = [];
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(UserDataService.uid)
          .collection('favorite')
          .get();
      for (var element in result.docs) {
        favoriteProduct.add(ProductsModel.fromJson(element.data()));
      }
      return Right(favoriteProduct);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, void>> removeProductFromFavorite(String productID) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserDataService.uid)
          .collection('favorite')
          .doc(productID)
          .delete();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
