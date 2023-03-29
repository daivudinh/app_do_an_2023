import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  const ReusableButton({
    Key? key,
    required this.onTap,
    required this.buttonTitle,
    required this.buttonColor,
  }) : super(key: key);

  final Function()? onTap;
  final String buttonTitle;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: AppColor.white25),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [buttonColor, buttonColor.withOpacity(0.5)]),
        ),
        child: Center(
          child: Text(buttonTitle, style: kTextSize20w400White),
        ),
      ),
    );
  }
}
