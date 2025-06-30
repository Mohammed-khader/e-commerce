part of '../view/cart_view.dart';

class _CheckOutButtonWidget extends StatelessWidget {
  const _CheckOutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartStates>(
      buildWhen: (_, current) {
        return current is CartUpdateCountState;
      },
      builder: (context, state) {
        return Padding(
          padding: AppPadding.horizontalpadding,
          child: Row(
            children: [
              Flexible(
                flex: 5,
                child: CustomButtons(
                  text: 'Checkout',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                flex: 4,
                child: CustomButtons(
                  color: Colors.green,
                  text: 'Total: \$${context.read<CartCubit>().totalPrice}',
                  onTap: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
