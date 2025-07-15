import 'package:first_project/core/theme/app_padding.dart';
import 'package:first_project/core/widgets/buttons/custom_buttons.dart';
import 'package:first_project/core/widgets/dialog/custom_loding_dialog.dart';
import 'package:first_project/core/widgets/snakbar/custom_snakbar.dart';
import 'package:first_project/features/product_details/model/products_model.dart';
import 'package:first_project/features/product_details/view_model/product_details_cubit.dart';
import 'package:first_project/features/product_details/view_model/product_details_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
part '../widget/favorite_icons_widget.dart';
part '../widget/product_info_widget.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.productDetails});

  final ProductsModel productDetails;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit(product: productDetails)..checkIfProductExisitInFavorite(),
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            _FavoriteIconsWidget(),
            SizedBox(width: 5),
            Icon(Icons.share),
            SizedBox(width: 10),
            SizedBox(width: 5),
          ],
        ),
        body: Padding(
          padding: AppPadding.allpadding,
          child: SingleChildScrollView(
            child: BlocListener<ProductDetailsCubit, ProductDetailsStates>(
              listener: (context, state) {
                _stateHandler(context, state);
              },
              child: Builder(
                builder: (context) {
                  return _ProductInfoWidget(productDetails: productDetails);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _stateHandler(BuildContext context, ProductDetailsStates state) {
  if (state is AddToCartLoadingState) {
    CustomLoadingDialog.show(context);
  } else if (state is AddToCartSuccesState) {
    Navigator.pop(context);
    CustomSnackbar.show(
      context,
      'Product Added To Cart',
      color: Colors.green,
    );
  } else if (state is AddToCartErrorState) {
    Navigator.pop(context);
    CustomSnackbar.show(context, state.error);
  }
}
