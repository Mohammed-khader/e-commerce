abstract class ChangePasswordStates {}

class ChangePasswordInitialState extends ChangePasswordStates {}

class ChangePasswordLoadingState extends ChangePasswordStates {}

class ChangePasswordErrorState extends ChangePasswordStates {
  final String error;

  ChangePasswordErrorState({required this.error});
}

class ChangePasswordSuccesState extends ChangePasswordStates {
  final String message;

  ChangePasswordSuccesState({required this.message});
}
