import 'package:first_project/core/extensions/extension.dart';
import 'package:first_project/core/local/user_data.dart';
import 'package:first_project/features/change_profile/repo/change_profile_repo.dart';
import 'package:first_project/features/change_profile/view_model/change_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeProfileCubit extends Cubit<ChangeProfileStates> {
  ChangeProfileCubit() : super(ChangeProfileInitialState());
  final _changeProfileRepo = ChangeProfileRepo();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  void getDefaultData() async {
    userNameController.text = UserDataService.username ?? '';
    phoneController.text = UserDataService.phone ?? '';
    emailController.text = UserDataService.email ?? '';
  }

  updateProfile() async {
    if (formKey.isValid()) {
      emit(ChangeProfileLoadingState());
      final result = await _changeProfileRepo.updateProfileData(
          userNameController.text, phoneController.text, emailController.text);
      result.fold(
        (error) => emit(ChangeProfileErrorState(error: error)),
        (_) => emit(ChangeProfileSuccessState()),
      );
    }
  }
}
