import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/features/login/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void logIn() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(LoginLoadingState());
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        emit(LoginSucessState());
      } on FirebaseAuthException catch (e) {
        emit(LoginErrorState(error: e.message ?? ''));
      }
    }
  }
}
