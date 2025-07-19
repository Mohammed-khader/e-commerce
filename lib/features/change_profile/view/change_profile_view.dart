import 'package:first_project/core/theme/app_colors.dart';
import 'package:first_project/core/theme/app_padding.dart';
import 'package:first_project/core/widgets/buttons/custom_buttons.dart';
import 'package:first_project/core/widgets/dialog/custom_loding_dialog.dart';
import 'package:first_project/core/widgets/text_field/custom_text_field.dart';
import 'package:first_project/core/widgets/toast_message/toast_message.dart';
import 'package:first_project/features/change_profile/view_model/change_profile_cubit.dart';
import 'package:first_project/features/change_profile/view_model/change_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeProfileView extends StatelessWidget {
  const ChangeProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeProfileCubit()..getDefaultData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: Text('Eidit Profile',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: AppPadding.allpadding,
          child: SingleChildScrollView(
            child: BlocListener<ChangeProfileCubit, ChangeProfileStates>(
              listener: (context, state) {
                if (state is ChangeProfileLoadingState) {
                  CustomLoadingDialog.show(context);
                } else if (state is ChangeProfileErrorState) {
                  Navigator.pop(context);
                  ToastMessage.showErrorMessage(context, state.error);
                } else if (state is ChangeProfileSuccessState) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ToastMessage.showSuccessMessage(
                      context, 'Profile updated successfully');
                }
              },
              child: Builder(builder: (context) {
                return _getTextFieldInfo(context);
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTextFieldInfo(BuildContext context) {
    return Form(
      key: context.read<ChangeProfileCubit>().formKey,
      child: Column(
        children: [
          const SizedBox(height: 15),
          CustomTextField(
            readOnly: true,
            keyboardType: TextInputType.emailAddress,
            label: 'Email',
            controller: context.read<ChangeProfileCubit>().emailController,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            keyboardType: TextInputType.name,
            validator: (username) {
              if (username?.isEmpty ?? true) {
                return "Please Enter a new  user name";
              }
              return null;
            },
            label: 'User Name',
            controller: context.read<ChangeProfileCubit>().userNameController,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            maxLength: 10,
            keyboardType: TextInputType.number,
            validator: (value) {
              bool isValidPhoneNumber(String phone) {
                final phoneRegex = RegExp(r'^\d{10}$');
                return phoneRegex.hasMatch(phone);
              }

              if (value == null || value.isEmpty) {
                return 'Please enter a new phone number';
              }

              if (!isValidPhoneNumber(value)) {
                return 'Phone number must be exactly 10 digits';
              }

              return null;
            },
            label: 'Phone',
            controller: context.read<ChangeProfileCubit>().phoneController,
          ),
          const SizedBox(height: 15),
          CustomButtons(
            text: 'Update',
            onTap: () {
              context.read<ChangeProfileCubit>().updateProfile();
            },
          )
        ],
      ),
    );
  }
}
