import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar_ui/components/buttons/main_button.dart';
import 'package:nectar_ui/components/inputs/custom_text_form_field.dart';
import 'package:nectar_ui/core/constants/app_assets.dart';
import 'package:nectar_ui/core/extentions/navigation.dart';
import 'package:nectar_ui/core/utils/app_colors.dart';
import 'package:nectar_ui/features/auth/page/register_screen.dart';
import 'package:nectar_ui/features/auth/widgets/auth_header.dart';
import 'package:nectar_ui/features/main/main_screen.dart';

// Wrap Your Column With "Form" Widget
// Create formKey as GlobalKey<FormState> and pass it to "Form" widget
// use validator for all form fields to validate them

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthHeader(
                      title: 'Welcome Back',
                      subTitle: 'Sign in to your account',
                    ),
                    SizedBox(height: 40),
                    CustomTextFormField(
                      labelText: 'Email',
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      labelText: 'Password',
                      obscureText: obscureText,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your password';
                        } else if (value!.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: obscureText
                            ? SvgPicture.asset(AppAssets.eyeSvg)
                            : Icon(
                                Icons.remove_red_eye,
                                color: AppColors.primaryColor,
                              ),
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
                    MainButton(
                      text: 'Login',
                      onPressed: () {
                        // if (formKey.currentState?.validate() ?? false) {
                        pushWithReplacement(context, MainScreen());
                        // }
                      },
                    ),
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
                            text: 'By conte to our ',
                            style: TextStyle(color: AppColors.greyColor),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Privacy Policy ',
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ),
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
                          onPressed: () {
                            pushWithReplacement(context, RegisterScreen());
                          },
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
      ),
    );
  }
}
