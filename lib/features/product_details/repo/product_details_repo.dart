import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:first_project/core/local/user_data.dart';
import 'package:first_project/features/product_details/model/products_model.dart';

class ProductDetailsRepo {
  Future<Either<String, bool>> addToCart({required ProductsModel productDetails}) async {
    try {
      final result = await _checkIfProductExisitInCart(productDetails.id);
      result.fold(
        (_) async => await _addNewProduct(productDetails),
        (productFromCart) async => await _updateProductCount(productFromCart),
      );
      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<void, ProductsModel>> _checkIfProductExisitInCart(String id) async {
    final reslut = await FirebaseFirestore.instance
        .collection('users')
        .doc(UserDataService.uid)
        .collection('cart')
        .doc(id)
        .get();
    if (reslut.exists) {
      ProductsModel product = ProductsModel.fromJson(reslut.data() ?? {});
      return Right(product);
    } else {
      return const Left(null);
    }
  }

  Future<void> _addNewProduct(ProductsModel product) async {
    product.count = 1;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(UserDataService.uid)
        .collection('cart')
        .doc(product.id)
        .set(product.toJson());
  }

  Future<void> _updateProductCount(ProductsModel product) async {
    product.count = (product.count ?? 0) + 1;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(UserDataService.uid)
        .collection('cart')
        .doc(product.id)
        .update(product.toJson());
  }
}
