import 'package:flutter/material.dart';
import 'package:tcc_le_app/core/styles/borders.dart';
import 'package:tcc_le_app/core/styles/colors.dart';
import 'package:tcc_le_app/core/styles/spaces.dart';
import 'package:tcc_le_app/core/styles/text_styles.dart';

class CustomInput extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function? onChanged;
  final Function? onFieldSubmitted;
  final Function? validator;
  final bool? obscure;
  final bool isPassword;
  final TextInputType? keyboardType;
  final IconData? icon;
  late BorderRadius? radius;
  CustomInput({
    super.key,
    this.hintText = "",
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.obscure = false,
    this.isPassword = false,
    this.icon,
    this.radius,
    this.keyboardType = TextInputType.text,
  }) {
    radius = radius ?? BorderRadius.circular(CustomBorders.radiusSM);
  }

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool obscure = true;

  @override
  void initState() {
    super.initState();
    this.obscure = widget.obscure!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: CustomSpacing.xxs),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: widget.radius!,
          color: CustomColors.background,
        ),
        child: TextFormField(
          controller: widget.controller,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          onFieldSubmitted: (value) {
            if (widget.onFieldSubmitted != null) {
              widget.onFieldSubmitted!(value);
            }
          },
          validator: (value) {
            if (widget.validator != null) {
              return widget.validator!(value);
            }
            return value;
          },
          style: CustomTextStyles.input,
          obscureText: obscure && widget.isPassword,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: CustomTextStyles.inputHint,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: CustomBorders.widthSM,
                color: CustomColors.feedbackError,
              ),
              borderRadius: widget.radius!,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: CustomBorders.widthSM,
                color: CustomColors.feedbackError,
              ),
              borderRadius: widget.radius!,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: CustomBorders.widthSM,
                color: CustomColors.neutralMedium,
              ),
              borderRadius: widget.radius!,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: CustomBorders.widthSM,
                color: CustomColors.neutralMedium,
              ),
              borderRadius: widget.radius!,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: CustomBorders.widthSM,
                color: CustomColors.primary,
              ),
              borderRadius: widget.radius!,
            ),
            prefixIcon:
                widget.icon == null
                    ? null
                    : Icon(widget.icon, color: CustomColors.neutralDark),
            suffixIcon:
                !widget.isPassword
                    ? null
                    : InkWell(
                      onTap: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      child: Container(
                        child: Icon(
                          obscure ? Icons.visibility : Icons.visibility_off,
                          color: CustomColors.neutralDark,
                        ),
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}
