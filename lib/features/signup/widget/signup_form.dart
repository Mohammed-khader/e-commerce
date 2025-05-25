import 'package:first_project/core/widgets/buttons/custom_buttons.dart';
import 'package:first_project/core/widgets/text_field/custom_text_field.dart';
import 'package:first_project/features/signup/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignUpCubit>().formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome To Shopease',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          CustomTextField(
            controller: context.read<SignUpCubit>().usernamecontrolar,
            label: 'User Name',
            keyboardType: TextInputType.name,
            validator: (username) {
              if (username?.isEmpty ?? true) {
                return "Pleass Enter your user name";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomTextField(
            keyboardType: TextInputType.number,
            label: 'Phone Number',
            controller: context.read<SignUpCubit>().phonecontrolar,
            maxLength: 10,
            validator: (value) {
              bool isValidPhoneNumber(String phone) {
                final phoneRegex = RegExp(r'^\d{10}$');
                return phoneRegex.hasMatch(phone);
              }

              if (value == null || value.isEmpty) {
                return 'Please enter a phone number';
              }

              if (!isValidPhoneNumber(value)) {
                return 'Phone number must be exactly 10 digits';
              }

              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomTextField(
            keyboardType: TextInputType.emailAddress,
            label: 'Email',
            controller: context.read<SignUpCubit>().emailcontrolar,
            validator: (value) {
              bool isValidEmail(String email) {
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                return emailRegex.hasMatch(email);
              }

              if (value == null || value.isEmpty) {
                return 'Please enter your email ';
              } else if (!isValidEmail(value)) {
                return '  Your email is not Valid ';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomTextField(
            label: 'Password',
            controller: context.read<SignUpCubit>().passwordcontrolar,
            obscureText: true,
            validator: (password) {
              if (password?.isEmpty ?? true) {
                return "pleass Enter your Password";
              } else if ((password?.length ?? 0) < 6) {
                return "password must be at least 8 characters";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: context.read<SignUpCubit>().confermepasswordcontrolar,
            label: 'Conferm password',
            obscureText: true,
            validator: (confermpassword) {
              if (confermpassword?.isEmpty ?? true) {
                return "pleass Enter your conferm password";
              } else if (confermpassword != context.read<SignUpCubit>().passwordcontrolar.text) {
                return "Confirm password does not match";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          CustomButtons(
            text: 'Create Account',
            onTap: () {
              context.read<SignUpCubit>().createAcoutn();
            },
          )
        ],
      ),
    );
  }
}
