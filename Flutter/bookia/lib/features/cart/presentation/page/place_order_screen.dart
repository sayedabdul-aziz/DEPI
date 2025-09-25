import 'package:bookia/components/app_bar/app_bar_with_back.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_field.dart';
import 'package:bookia/core/extentions/app_regex.dart';
import 'package:bookia/core/extentions/dialogs.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/widgets/gov_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key, required this.totalAmount});

  final String totalAmount;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CheckoutSuccessState) {
          pop(context);
          pushAndRemoveUntil(context, Routes.main, extra: 0);
        } else if (state is CheckoutLoadingState) {
          showLoadingDialog(context);
        } else if (state is CartErrorState) {
          pop(context);
          showMyDialog(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBarWithBack(),
        body: orderForm(context),
        bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            var cubit = context.read<CartCubit>();
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('Total:', style: TextStyles.getSize18()),
                        const Spacer(),
                        Text('\$ $totalAmount', style: TextStyles.getSize18()),
                      ],
                    ),
                    const Gap(20),
                    MainButton(
                      text: 'Checkout',
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.placeOrder();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding orderForm(BuildContext context) {
    var cubit = context.read<CartCubit>();
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Form(
        key: cubit.formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Place Your Order', style: TextStyles.getSize24()),
              Gap(8),
              Text(
                'Place your order and get it delivered to your doorstep in 24 hours or less',
                style: TextStyles.getSize16(color: AppColors.greyColor),
              ),
              Gap(20),
              CustomTextField(
                controller: cubit.nameController,
                hintText: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              Gap(15),
              CustomTextField(
                controller: cubit.emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!AppRegex.isEmailValid(
                    cubit.emailController.text,
                  )) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              Gap(15),
              CustomTextField(
                controller: cubit.addressController,
                hintText: 'Address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              Gap(15),
              CustomTextField(
                controller: cubit.phoneController,
                hintText: 'Phone',
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11),
                  // deny special characters
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (!AppRegex.isEgyptPhoneValid(
                    cubit.phoneController.text,
                  )) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              Gap(15),
              CustomTextField(
                controller: cubit.governorateController,
                readOnly: true,
                suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                hintText: 'Governorate',
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please select your governorate';
                  }
                  return null;
                },
                onTap: () {
                  showGovList(context, cubit);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
