import 'package:first_project/core/extensions/extension.dart';
import 'package:first_project/features/signup/repo/signup_repo.dart';
import 'package:first_project/features/signup/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());
  final _signupRepo = SignUpRepo();
  final formKey = GlobalKey<FormState>();
  final usernamecontrolar = TextEditingController();
  final phonecontrolar = TextEditingController();
  final emailcontrolar = TextEditingController();
  final passwordcontrolar = TextEditingController();
  final confirmpasswordcontrolar = TextEditingController();

  void createAcoutn() async {
    if (formKey.isValid()) {
      emit(SignUpLoadingState());
      final result = await _signupRepo.createAccountRequest(
        email: emailcontrolar.text,
        password: passwordcontrolar.text,
        username: usernamecontrolar.text,
        phone: phonecontrolar.text,
      );
      result.fold((error) => emit(SignUpErrorState(error: error)),
          (user) => emit(SignUpSuccessState(credential: user)));
    }
  }

  @override
  Future<void> close() {
    usernamecontrolar.dispose();
    phonecontrolar.dispose();
    emailcontrolar.dispose();
    passwordcontrolar.dispose();
    confirmpasswordcontrolar.dispose();

    return super.close();
  }
}
