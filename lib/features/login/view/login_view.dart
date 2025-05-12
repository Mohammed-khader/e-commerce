import 'package:first_project/core/theme/app_colors.dart';
import 'package:first_project/core/theme/app_images.dart';
import 'package:first_project/core/theme/app_padding.dart';
import 'package:first_project/core/widgets/dialog/custom_loding_dialog.dart';
import 'package:first_project/features/login/widget/login_form.dart';
import 'package:first_project/core/widgets/snakbar/custom_snakbar.dart';
import 'package:first_project/features/home/home_view.dart';
import 'package:first_project/features/login/view_model/cubit.dart';
import 'package:first_project/features/login/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Padding(
            padding: AppPadding.horizontalpadding,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Lottie.asset(AppImages.loginLogo,
                        width: MediaQuery.of(context).size.width / 2.5),
                    SizedBox(
                      height: 500,
                      child: Card(
                        color: Colors.white,
                        elevation: 6,
                        child: Padding(
                          padding: AppPadding.allpadding,
                          child: BlocListener<LoginCubit, LoginStates>(
                            listener: (context, state) {
                              if (state is LoginSucessState) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) {
                                    return const HomeView();
                                  },
                                ));
                              } else if (state is LoginErrorState) {
                                Navigator.pop(context);
                                CustomSnackbar.show(context, state.error);
                              } else if (state is LoginLoadingState) {
                                CustomLoadingDialog.show(context);
                              }
                            },
                            child: const LoginForm(),
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
      ),
    );
  }
}
