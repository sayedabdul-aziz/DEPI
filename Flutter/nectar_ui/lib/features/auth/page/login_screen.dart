import 'package:flutter/material.dart';
import 'package:nectar_ui/components/buttons/main_button.dart';
import 'package:nectar_ui/components/inputs/custom_text_form_field.dart';
import 'package:nectar_ui/core/utils/app_colors.dart';
import 'package:nectar_ui/features/auth/widgets/auth_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthHeader(),
                  SizedBox(height: 40),
                  CustomTextFormField(labelText: 'Email'),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    labelText: 'Password',
                    onChanged: (value) {},
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MainButton(text: 'Login', onPressed: () {}),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'By continuing you agree to our ',
                          style: TextStyle(color: AppColors.greyColor),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Privacy Policy ',
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                        TextSpan(
                          text: 'By continuing you agree to our ',
                          style: TextStyle(color: AppColors.greyColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: AppColors.greyColor),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ],
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
