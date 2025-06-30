import 'package:first_project/core/widgets/icons/view_model/cart_icon_states.dart';
import 'package:first_project/features/cart/repo/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartIconCubit extends Cubit<CartIconStates> {
  CartIconCubit() : super(CartIconInitialState());
  final _cartRepo = CartRepo();
  int count = 0;
  Future<void> getcount() async {
    emit(CartIconLoadingState());
    final result = await _cartRepo.getCount();
    result.fold(
      (error) => emit(CartIconErrorState(error: error)),
      (count) {
        this.count = count;
        emit(CartIconSuccessState(count: count));
      },
    );
  }
}
