import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class DisplayResolution4K extends StatelessWidget {
  const DisplayResolution4K({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 40.0,
      decoration: BoxDecoration(
        color: AppColor.genreItemColor,
        border: Border.all(color: AppColor.white, width: 0.2),
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.white, AppColor.white25],
        ),
      ),
      child: const Center(
          child: Text(
        '4K',
        style: kTextSize15w400White,
      )),
    );
  }
}
