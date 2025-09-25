import 'package:bookia/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.inputFormatters,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      obscureText: widget.isPassword && isObscure,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon:
            widget.suffixIcon ??
            (widget.isPassword
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [SvgPicture.asset(AppImages.eyeSvg)],
                      ),
                    ),
                  )
                : null),
      ),
      validator: widget.validator,
    );
  }
}
