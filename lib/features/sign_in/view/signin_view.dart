import 'package:first_project/core/theme/app_colors.dart';
import 'package:first_project/core/theme/app_images.dart';
import 'package:first_project/core/theme/app_padding.dart';
import 'package:first_project/core/widgets/dialog/custom_loding_dialog.dart';
import 'package:first_project/core/widgets/snakbar/custom_snakbar.dart';
import 'package:first_project/features/Sign_in/view_model/cubit.dart';
import 'package:first_project/features/Sign_in/view_model/states.dart';
import 'package:first_project/features/Sign_in/widget/signin_form.dart';
import 'package:first_project/features/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Center(
            child: SafeArea(
              child: Column(
                children: [
                  Lottie.asset(
                    AppImages.signIn,
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  Padding(
                    padding: AppPadding.allpadding,
                    child: SizedBox(
                      height: 650,
                      child: Card(
                        elevation: 6,
                        child: Padding(
                          padding: AppPadding.allpadding,
                          child: BlocListener<SignInCubit, SignInStates>(
                            listener: (context, state) {
                              if (state is SignInSuccessState) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginView(),
                                  ),
                                );
                              } else if (state is SignInErrorState) {
                                Navigator.pop(context);
                                CustomSnackbar.show(context, state.error);
                              } else if (state is SignInLoadingState) {
                                CustomLoadingDialog.show(context);
                              }
                            },
                            child: const SigninForm(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
