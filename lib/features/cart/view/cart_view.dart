import 'package:first_project/core/theme/app_colors.dart';
import 'package:first_project/core/theme/app_padding.dart';
import 'package:first_project/core/widgets/buttons/custom_buttons.dart';
import 'package:first_project/core/widgets/icons/view_model/cart_icon_cubit.dart';
import 'package:first_project/features/cart/view_model/cart_cubit.dart';
import 'package:first_project/features/cart/view_model/cart_states.dart';
import 'package:first_project/features/product_details/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
part '../widget/cart_item_wedget.dart';
part '../widget/counter_wigdet.dart';
part '../widget/checkout_button_widget.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCartItems(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Cart',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<CartCubit, CartStates>(
            listener: (BuildContext context, CartStates state) {
              if (state is CartRemoveProductsState) {
                context.read<CartIconCubit>().getcount();
              }
            },
            builder: (context, state) {
              final cartCubit = context.read<CartCubit>();
              final products = cartCubit.cartProduct;

              if (state is CartLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartErrorState) {
                return Center(
                  child: Text(state.error),
                );
              } else if (products.isEmpty) {
                return Center(
                  child: Text(
                    'No product added',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return CartItemWedget(
                            product: products[index],
                            index: index,
                          );
                        },
                      ),
                    ),
                    const _CheckOutButtonWidget(),
                    const SizedBox(height: 10),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
