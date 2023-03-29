import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class ReusableTextField extends StatefulWidget {
  ReusableTextField(
      {Key? key,
      this.obscureText = false,
      required this.controller,
      this.textInputAction,
      this.keyboardType,
      this.enabled = true,
      this.hintText,
      this.suffixIcon = false})
      : super(key: key);

  bool obscureText;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool enabled;
  final String? hintText;
  final bool suffixIcon;

  @override
  State<ReusableTextField> createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
      controller: widget.controller,
      style: kTextSize20w400White,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.enabled
            ? AppColor.background
            : AppColor.blur.withOpacity(0.1),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5, color: AppColor.blur),
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintStyle: kTextSize20w400Blur,
        suffixIcon: widget.suffixIcon
            ? GestureDetector(
                onTap: () => setState(() {
                      widget.obscureText = !widget.obscureText;
                    }),
                child: Icon(
                  widget.obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColor.blur,
                ))
            : null,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.all(15.0),
        focusColor: AppColor.yellow,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5, color: AppColor.white),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
