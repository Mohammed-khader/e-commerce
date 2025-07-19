abstract class ChangeProfileStates {}

class ChangeProfileInitialState extends ChangeProfileStates {}

class ChangeProfileLoadingState extends ChangeProfileStates {}

class ChangeProfileErrorState extends ChangeProfileStates {
  final String error;

  ChangeProfileErrorState({required this.error});
}

class ChangeProfileSuccessState extends ChangeProfileStates {}
