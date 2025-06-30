import 'package:first_project/core/widgets/icons/view_model/cart_icon_cubit.dart';
import 'package:first_project/core/widgets/icons/view_model/cart_icon_states.dart';
import 'package:first_project/features/cart/view/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartIconView extends StatelessWidget {
  final VoidCallback onPressed;

  const CartIconView({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart, size: 30, color: Colors.black),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                        value: context.read<CartIconCubit>(),
                        child: const CartView(),
                      )),
            );
          },
        ),
        BlocBuilder<CartIconCubit, CartIconStates>(
          builder: (context, state) {
            if (state is CartIconLoadingState) {
              return const Positioned(
                right: 0,
                top: -5,
                child: SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            } else if (state is CartIconSuccessState && state.count > 0) {
              return Positioned(
                right: 0,
                top: -5,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Text(
                    state.count.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
