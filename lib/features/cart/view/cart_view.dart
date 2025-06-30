import 'package:first_project/core/theme/app_colors.dart';
import 'package:first_project/core/theme/app_padding.dart';
import 'package:first_project/core/widgets/buttons/custom_buttons.dart';
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
          child: BlocBuilder<CartCubit, CartStates>(
            builder: (context, state) {
              if (state is CartLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartErrorState) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: context.read<CartCubit>().cartProduct.length,
                        itemBuilder: (context, index) {
                          return CartItemWedget(
                            product: context.read<CartCubit>().cartProduct[index],
                            index: index,
                          );
                        },
                      ),
                    ),
                    const _CheckOutButtonWidget(),
                    const SizedBox(height: 10)
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
