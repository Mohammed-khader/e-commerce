import 'package:first_project/core/extensions/extension.dart';
import 'package:first_project/features/change_password/repo/change_password_repo.dart';
import 'package:first_project/features/change_password/view_model/change_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());
  final _changePasswordRepo = ChangePasswordRepo();
  final newPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void changePassword() async {
    if (formKey.isValid()) {
      emit(ChangePasswordLoadingState());
      final result = await _changePasswordRepo.changePassword(
        newPasswordController.text,
        oldPasswordController.text,
      );
      result.fold(
        (error) => emit(ChangePasswordErrorState(error: error)),
        (message) => emit(ChangePasswordSuccesState(message: message)),
      );
    }
  }
}
