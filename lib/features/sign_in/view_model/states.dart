abstract class SignInStates {}

class SignInInitialState extends SignInStates {}

class SignInLoadingState extends SignInStates {}

class SignInErrorState extends SignInStates {
  final String error;

  SignInErrorState({required this.error});
}

class SignInSuccessState extends SignInStates {}
