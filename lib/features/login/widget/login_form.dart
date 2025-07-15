import 'package:first_project/core/theme/app_colors.dart';
import 'package:first_project/core/widgets/buttons/custom_buttons.dart';
import 'package:first_project/core/widgets/text_field/custom_text_field.dart';
import 'package:first_project/features/login/view_model/login_cubit.dart';
import 'package:first_project/features/signup/view/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome To Shopease',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Login',
            style: GoogleFonts.poppins(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: context.read<LoginCubit>().emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              if (email?.isEmpty ?? true) {
                return 'Please Enter Your Email';
              }
              return null;
            },
            label: 'Email',
          ),
          const SizedBox(height: 10),
          CustomTextField(
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            controller: context.read<LoginCubit>().passwordController,
            validator: (password) {
              if (password?.isEmpty ?? true) {
                return 'Please Enter Your Password';
              }
              return null;
            },
            label: 'Password',
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: Text(
              'Forget Passowrd ?',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomButtons(
            text: 'Login',
            onTap: () {
              context.read<LoginCubit>().logIn();
            },
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Text(
                'Do you have an account ? ',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignUp();
                      },
                    ),
                  );
                },
                child: Text(
                  'Sign Up ',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
