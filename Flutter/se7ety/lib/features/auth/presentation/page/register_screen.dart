import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/core/extentions/app_regex.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/user_type_enum.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isVisible = true;

  String handleUserType() {
    return widget.userType == UserTypeEnum.doctor ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: const BackButton(color: AppColors.primaryColor),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', height: 200),
                  const SizedBox(height: 20),
                  Text(
                    'سجل دخول الان كـ "${handleUserType()}"',
                    style: TextStyles.title,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'اسم المستخدم',
                      prefixIcon: Icon(Icons.person),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل الاسم';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    textAlign: TextAlign.end,
                    decoration: const InputDecoration(
                      hintText: 'Sayed@example.com',
                      prefixIcon: Icon(Icons.email_rounded),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل الايميل';
                      } else if (!AppRegex.isEmailValid(value)) {
                        return 'من فضلك ادخل الايميل صحيحا';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25.0),
                  TextFormField(
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: AppColors.darkColor),
                    obscureText: isVisible,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: '********',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(
                          (isVisible)
                              ? Icons.remove_red_eye
                              : Icons.visibility_off_rounded,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                      return null;
                    },
                  ),

                  const Gap(20),
                  MainButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {}
                    },
                    text: "تسجيل حساب جديد",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'لدي حساب ؟',
                          style: TextStyles.body.copyWith(
                            color: AppColors.darkColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            pushWithReplacement(
                              context,
                              Routes.login,
                              extra: widget.userType,
                            );
                          },
                          child: Text(
                            'سجل دخول',
                            style: TextStyles.body.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
