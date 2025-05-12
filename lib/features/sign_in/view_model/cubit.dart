import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/core/extensions/extension.dart';
import 'package:first_project/features/Sign_in/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit() : super(SignInInitialState());
  final formKey = GlobalKey<FormState>();
  final usernamecontrolar = TextEditingController();
  final phonecontrolar = TextEditingController();
  final emailcontrolar = TextEditingController();
  final passwordcontrolar = TextEditingController();
  final confermepasswordcontrolar = TextEditingController();

  void createAcoutn() async {
    if (formKey.isValid()) {
      emit(SignInLoadingState());
      // Future.delayed(const Duration(seconds: 2)).then((_) {});
      try {
        // final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontrolar.text,
          password: passwordcontrolar.text,
        );
        emit(SignInSuccessState());
      } on FirebaseAuthException catch (e) {
        String errorMessage = '';
        if (e.code == 'weak-password') {
          errorMessage = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for that email.';
        }
        emit(SignInErrorState(error: errorMessage));
      }
    }
  }
}
