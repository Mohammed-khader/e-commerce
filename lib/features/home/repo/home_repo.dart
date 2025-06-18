import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:first_project/features/home/model/category_model.dart';
import 'package:first_project/features/product_details/model/products_model.dart';

class HomeRepo {
  Future<Either<String, List<CategoryModel>>> getCategory() async {
    try {
      List<CategoryModel> categories = [];
      final snapshot = await FirebaseFirestore.instance.collection('categories').get();
      for (var element in snapshot.docs) {
        categories.add(CategoryModel.fromJson(element.data()));
      }
      return Right(categories);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, List<ProductsModel>>> getProductsByCategoryID(String categoryID) async {
    try {
      List<ProductsModel> product = [];
      final snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryID)
          .collection('products')
          .get();
      for (var element in snapshot.docs) {
        product.add(ProductsModel.fromJson(element.data()));
      }
      return Right(product);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
