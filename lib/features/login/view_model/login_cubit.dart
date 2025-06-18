import 'package:first_project/features/login/repo/login_repo.dart';
import 'package:first_project/features/login/view_model/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  final _loginrepo = LoginRepo();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void logIn() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(LoginLoadingState());
      final result = await _loginrepo.loginRepoRequast(
        email: emailController.text,
        password: passwordController.text,
      );
      result.fold(
        (error) => emit(LoginErrorState(error: error)),
        (user) => emit(LoginSuccesstate()),
      );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
