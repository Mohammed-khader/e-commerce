import 'package:first_project/core/theme/app_colors.dart';
import 'package:first_project/core/widgets/buttons/custom_buttons.dart';
import 'package:first_project/core/widgets/dialog/custom_loding_dialog.dart';
import 'package:first_project/core/widgets/text_field/custom_text_field.dart';
import 'package:first_project/core/widgets/toast_message/toast_message.dart';
import 'package:first_project/features/change_password/view_model/change_password_cubit.dart';
import 'package:first_project/features/change_password/view_model/change_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: Text('Change Password',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocListener<ChangePasswordCubit, ChangePasswordStates>(
              listener: (context, state) {
                if (state is ChangePasswordLoadingState) {
                  CustomLoadingDialog.show(context);
                } else if (state is ChangePasswordErrorState) {
                  Navigator.pop(context);
                  ToastMessage.showErrorMessage(context, state.error);
                } else if (state is ChangePasswordSuccesState) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ToastMessage.showSuccessMessage(context, state.message);
                }
              },
              child: Builder(builder: (context) {
                return Form(
                  key: context.read<ChangePasswordCubit>().formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        label: 'Old Password',
                        controller:
                            context.read<ChangePasswordCubit>().oldPasswordController,
                        obscureText: true,
                        validator: (password) {
                          if (password?.isEmpty ?? true) {
                            return "Please Enter Your Old Password";
                          } else if ((password?.length ?? 0) < 8) {
                            return "password must be at least 8 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: 'New Password',
                        controller:
                            context.read<ChangePasswordCubit>().newPasswordController,
                        obscureText: true,
                        validator: (password) {
                          if (password?.isEmpty ?? true) {
                            return "Please Enter A New Password";
                          } else if ((password?.length ?? 0) < 6) {
                            return "password must be at least 8 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      CustomButtons(
                        text: 'Update Password',
                        onTap: () {
                          context.read<ChangePasswordCubit>().changePassword();
                        },
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
