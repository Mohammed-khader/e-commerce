import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpErrorState extends SignUpStates {
  final String error;

  SignUpErrorState({required this.error});
}

class SignUpSuccessState extends SignUpStates {
  final UserCredential credential;

  SignUpSuccessState({required this.credential});
}
